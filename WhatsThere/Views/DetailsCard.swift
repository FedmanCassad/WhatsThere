//
//  DetailsCard.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 08.03.2021.
//

import UIKit
import SVGKit

final class DetailedCard: UIView {
  
  private lazy var weatherIcon: UIImageView = {
    let imageView = UIImageView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 50,
                                              height: 5))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private lazy var cityNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  
  private lazy var minimumTempTitleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.text = "Мин. \u{2103}"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var minimumTempLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var currentTempLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.clipsToBounds = true
    label.layer.cornerRadius = 15
    label.backgroundColor = UIColor.white.withAlphaComponent(0.4)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var maximumTempTitleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.text = "Макс. \u{2103}"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var maximumTempLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var commonConstraints: [NSLayoutConstraint] = [
    weatherIcon.widthAnchor.constraint(equalToConstant: 50),
    weatherIcon.heightAnchor.constraint(equalToConstant: 50),
    weatherIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
    weatherIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
    cityNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
    cityNameLabel.heightAnchor.constraint(equalToConstant: 35),
    cityNameLabel.centerXAnchor.constraint(equalTo: weatherIcon.centerXAnchor),
    cityNameLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 10),
    currentTempLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.3),
    currentTempLabel.heightAnchor.constraint(equalToConstant: 50),
    currentTempLabel.centerXAnchor.constraint(equalTo: cityNameLabel.centerXAnchor),
    currentTempLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 10),
    minimumTempLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
    minimumTempLabel.trailingAnchor.constraint(equalTo: currentTempLabel.leadingAnchor, constant: -5),
    minimumTempLabel.heightAnchor.constraint(equalTo: currentTempLabel.heightAnchor),
    minimumTempLabel.centerYAnchor.constraint(equalTo: currentTempLabel.centerYAnchor),
    maximumTempLabel.leadingAnchor.constraint(equalTo: currentTempLabel.trailingAnchor, constant: 5),
    maximumTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
    maximumTempLabel.heightAnchor.constraint(equalTo: currentTempLabel.heightAnchor),
    maximumTempLabel.centerYAnchor.constraint(equalTo: currentTempLabel.centerYAnchor),
    minimumTempTitleLabel.widthAnchor.constraint(equalTo: minimumTempLabel.widthAnchor),
    minimumTempTitleLabel.centerXAnchor.constraint(equalTo: minimumTempLabel.centerXAnchor),
    minimumTempTitleLabel.heightAnchor.constraint(equalToConstant: 30),
    minimumTempTitleLabel.bottomAnchor.constraint(equalTo: minimumTempLabel.topAnchor, constant: -5),
    maximumTempTitleLabel.widthAnchor.constraint(equalTo: maximumTempLabel.widthAnchor),
    maximumTempTitleLabel.centerXAnchor.constraint(equalTo: maximumTempLabel.centerXAnchor),
    maximumTempTitleLabel.heightAnchor.constraint(equalToConstant: 30),
    maximumTempTitleLabel.bottomAnchor.constraint(equalTo: maximumTempLabel.topAnchor, constant: -5),
  ]
  
  func configure(with city: YandexForecast) {
    cityNameLabel.text = city.cityObject.locality.name
    currentTempLabel.text = String(city.currentWeather.temp)
    minimumTempLabel.text = String(city.nextDaysForecasts[0].partialForecast.day.minimumTemp)
    maximumTempLabel.text = String(city.nextDaysForecasts[0].partialForecast.day.maximumTemp)
    let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(city.currentWeather.icon).svg")
    let image = SVGKImage(contentsOf: url)
    weatherIcon.image = image?.uiImage
    backgroundColor = TemperatureColor.colorDepending(onTemperatureValue: city.currentWeather.temp).color
    setupUI()
  }
  
  private func setupUI() {
    [weatherIcon,
     cityNameLabel,
     currentTempLabel,
     minimumTempLabel,
     maximumTempLabel,
     minimumTempTitleLabel,
     maximumTempTitleLabel
    ].forEach {
      addSubview($0)
     }
    NSLayoutConstraint.activate(commonConstraints)
  }
}
