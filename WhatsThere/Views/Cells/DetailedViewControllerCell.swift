//
//  DetailedViewvControllerCell.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 08.03.2021.
//

import UIKit
import SVGKit

final class DetailedViewControllerCell: UITableViewCell {
  private weak var iconsCache: IconsStorage?
  private var forecast: YandexForecast.Forecast? {
    willSet {
      guard let newValue = newValue else {return}
      updateMyUIs(with: newValue)
    }
  }
  
  private lazy var weekdayLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.textAlignment = .right
    return label
  }()
  
  private lazy var weatherIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private lazy var humidityLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.backgroundColor = .clear
    label.textAlignment = .center
    label.textColor = .systemTeal
    label.font = UIFont.boldSystemFont(ofSize: 9)
    return label
  }()
  
  private lazy var minimumTempLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  private lazy var maximumTempLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  func configure(with forecast: YandexForecast.Forecast, cache: IconsStorage) {
    self.iconsCache = cache
    self.forecast = forecast
    contentView.backgroundColor = UIColor.UIColorFromHex(hex: "#315760ff")
    layoutMySubviews()
  }
  
  //TODO: вынести обновление UI
  private func updateMyUIs(with forecast: YandexForecast.Forecast) {
    var date = forecast.date
    date.convertToLocalWeekday()
    weekdayLabel.text = date
    humidityLabel.text = "\(forecast.partialForecast.day.humidity) %"
    minimumTempLabel.text = String(forecast.partialForecast.day.minimumTemp)
    maximumTempLabel.text = String(forecast.partialForecast.day.maximumTemp)
    if weatherIcon.image == nil {
      let iconString = forecast.partialForecast.day.icon
      checkIconImageExisting(for: iconString)
    }
  }
  
  private func checkIconImageExisting(for iconString: String) {
    if let image = iconsCache?.getTheIconFromStorage(iconString: iconString) {
      weatherIcon.image = image
    } else {
     
      DispatchQueue.global(qos: .userInteractive).async {[weak self] in
        if let retrievedIcon = self?.getIconImage(for: iconString){
          self?.iconsCache?.saveIconToStorage(iconString: iconString, image: retrievedIcon.uiImage)
          DispatchQueue.main.sync {
            self?.weatherIcon.image = retrievedIcon.uiImage
          }
        }
      }
    }
  }
  
  private lazy var commonConstraints: [NSLayoutConstraint] = [
    weekdayLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
    weekdayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    weekdayLabel.widthAnchor.constraint(equalToConstant: 120),
    weekdayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
    weatherIcon.heightAnchor.constraint(equalTo: weekdayLabel.heightAnchor),
    weatherIcon.widthAnchor.constraint(equalTo: weatherIcon.heightAnchor),
    weatherIcon.leadingAnchor.constraint(equalTo: weekdayLabel.trailingAnchor, constant: 10),
    weatherIcon.centerYAnchor.constraint(equalTo: weekdayLabel.centerYAnchor),
    humidityLabel.heightAnchor.constraint(equalTo: weatherIcon.heightAnchor),
    humidityLabel.widthAnchor.constraint(equalTo: humidityLabel.heightAnchor),
    humidityLabel.centerYAnchor.constraint(equalTo: weatherIcon.centerYAnchor),
    humidityLabel.leadingAnchor.constraint(equalTo: weatherIcon.trailingAnchor, constant: 10),
    minimumTempLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
    minimumTempLabel.widthAnchor.constraint(equalTo: minimumTempLabel.heightAnchor),
    minimumTempLabel.centerYAnchor.constraint(equalTo: humidityLabel.centerYAnchor),
    minimumTempLabel.leadingAnchor.constraint(equalTo: humidityLabel.trailingAnchor, constant: 10),
    maximumTempLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
    maximumTempLabel.widthAnchor.constraint(equalTo: maximumTempLabel.heightAnchor),
    maximumTempLabel.centerYAnchor.constraint(equalTo: minimumTempLabel.centerYAnchor),
    maximumTempLabel.leadingAnchor.constraint(equalTo: minimumTempLabel.trailingAnchor, constant: 10),
  ]
  
  private func layoutMySubviews() {
    contentView.addSubview(weekdayLabel)
    contentView.addSubview(weatherIcon)
    contentView.addSubview(humidityLabel)
    contentView.addSubview(minimumTempLabel)
    contentView.addSubview(maximumTempLabel)
    NSLayoutConstraint.activate(commonConstraints)
  }
}

//MARK: - Retrieving SVG image
extension DetailedViewControllerCell {
  private func getIconImage(for icon: String) -> SVGKImage? {
    let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(icon).svg")
    return SVGKImage(contentsOf: url)
  }
}
