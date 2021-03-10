//
//  MainViewControllerCell.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 07.03.2021.
//

import UIKit
import SVGKit

final class MainTableViewCell: UITableViewCell {
  
  private lazy var cityNameLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = UIColor.white.withAlphaComponent(0)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.textAlignment = .center
    return label
  }()
  
  private lazy var regionNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.backgroundColor = .white
    label.textAlignment = .center
    label.backgroundColor = UIColor.white.withAlphaComponent(0)
    label.font = UIFont.boldSystemFont(ofSize: 9)
    label.textColor = .black
    return label
  }()
  
  private lazy var weatherIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private lazy var transparentView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var tempLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    return label
  }()
  
  //MARK: - Set of constraints
  lazy var commonConstraints: [NSLayoutConstraint] = [
    cityNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
    cityNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
    cityNameLabel.heightAnchor.constraint(equalToConstant: 30),
    cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
    regionNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
    regionNameLabel.heightAnchor.constraint(equalToConstant: 30),
    regionNameLabel.centerXAnchor.constraint(equalTo:cityNameLabel.centerXAnchor),
    regionNameLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 5),
    tempLabel.widthAnchor.constraint(equalToConstant: 70),
    tempLabel.heightAnchor.constraint(equalToConstant: 50),
    tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
    tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
    transparentView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
    transparentView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
    transparentView.topAnchor.constraint(equalTo: contentView.topAnchor),
    transparentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    transparentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
    transparentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
    weatherIcon.widthAnchor.constraint(equalToConstant: 40),
    weatherIcon.heightAnchor.constraint(equalToConstant: 40),
    weatherIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
    weatherIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
  ]
  
  //MARK: - When cell becomes visible we configurate content in a moment of updating forecast var
  private var forecast: YandexForecast? {
    willSet {
      guard let newValue = newValue else {return}
      contentView.backgroundColor = TemperatureColor.colorDepending(onTemperatureValue: newValue.currentWeather.temp).color
      cityNameLabel.text = newValue.cityObject.locality.name
      cityNameLabel.layer.cornerRadius = 30
      regionNameLabel.text = newValue.cityObject.province.name
      tempLabel.backgroundColor = contentView.backgroundColor
      if weatherIcon.image == nil {
        DispatchQueue.global(qos: .userInteractive).async {
          guard let svgIcon = self.getIconImage(for: newValue.currentWeather.icon) else {return}
          DispatchQueue.main.async {
            self.weatherIcon.image = svgIcon.uiImage
          }
        }
      }
      tempLabel.text = String(newValue.currentWeather.temp)
    }
  }
  
  //MARK: - Configuring cell entry point
  func configureCell(with forecast: YandexForecast) {
    self.forecast = forecast
    self.setupUI()
  }
  
  private func setupUI() {
    contentView.addSubview(transparentView)
    contentView.addSubview(cityNameLabel)
    contentView.addSubview(regionNameLabel)
    contentView.addSubview(tempLabel)
    contentView.addSubview(weatherIcon)
    NSLayoutConstraint.activate(commonConstraints)
    
  }
  
}
//MARK: - Retrieving SVG image
extension MainTableViewCell {
  private func getIconImage(for icon: String) -> SVGKImage? {
    let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(icon).svg")
    return SVGKImage(contentsOf: url)
  }
}
