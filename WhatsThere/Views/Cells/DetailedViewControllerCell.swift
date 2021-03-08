//
//  DetailedViewvControllerCell.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 08.03.2021.
//

import UIKit
import SVGKit

final class DetailedViewControllerCell: UITableViewCell {
  private var forecast: YandexForecast.Forecast? {
    willSet {
      guard let newValue = newValue else {return}
      var date = newValue.date
      date.convertToLocalWeekday()
      weekdayLabel.text = date
      humidityLabel.text = "\(newValue.partialForecast.day.humidity) %"
      if weatherIcon.image == nil {
        weatherIcon.image = self.getIconImage(for: newValue.partialForecast.day.icon)
      }
      minimumTempLabel.text = String(newValue.partialForecast.day.minimumTemp)
      maximumTempLabel.text = String(newValue.partialForecast.day.maximumTemp)
    }
  }
  
  private lazy var weekdayLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = .clear
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.textAlignment = .center
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
  
  func configure(with forecast: YandexForecast.Forecast) {
    self.forecast = forecast
    contentView.backgroundColor = .clear
    layoutMySubviews()
  }
  
  private lazy var commonConstraints: [NSLayoutConstraint] = [
    weekdayLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
    weekdayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    weekdayLabel.widthAnchor.constraint(equalToConstant: 120),
    weekdayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
    weatherIcon.heightAnchor.constraint(equalTo: weekdayLabel.heightAnchor),
    weatherIcon.widthAnchor.constraint(equalTo: weatherIcon.heightAnchor),
    weatherIcon.leadingAnchor.constraint(equalTo: weekdayLabel.trailingAnchor, constant: 5),
    weatherIcon.centerYAnchor.constraint(equalTo: weekdayLabel.centerYAnchor),
    humidityLabel.heightAnchor.constraint(equalTo: weatherIcon.heightAnchor),
    humidityLabel.widthAnchor.constraint(equalTo: humidityLabel.heightAnchor),
    humidityLabel.centerYAnchor.constraint(equalTo: weatherIcon.centerYAnchor),
    humidityLabel.leadingAnchor.constraint(equalTo: weatherIcon.trailingAnchor, constant: 5),
    minimumTempLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
    minimumTempLabel.widthAnchor.constraint(equalTo: minimumTempLabel.heightAnchor),
    minimumTempLabel.centerYAnchor.constraint(equalTo: humidityLabel.centerYAnchor),
    minimumTempLabel.leadingAnchor.constraint(equalTo: humidityLabel.trailingAnchor, constant: 10),
    maximumTempLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
    maximumTempLabel.widthAnchor.constraint(equalTo: maximumTempLabel.heightAnchor),
    maximumTempLabel.centerYAnchor.constraint(equalTo: minimumTempLabel.centerYAnchor),
    maximumTempLabel.leadingAnchor.constraint(equalTo: minimumTempLabel.trailingAnchor, constant: 5),
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
  private func getIconImage(for icon: String) -> UIImage {
    let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(icon).svg")
    guard  let image = SVGKImage(contentsOf: url) else
    {
      return UIImage()
    }
    return image.uiImage
  }
}
