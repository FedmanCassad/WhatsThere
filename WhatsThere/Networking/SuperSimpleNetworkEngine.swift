//
//  GeocoderService.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 06.03.2021.
//

import UIKit

final class SuperSimpleNetworkEngine {
  var yandexWeatherURL: URL! = URL(string: "https://api.weather.yandex.ru/v2/forecast")
  var session: URLSession {
    URLSession.shared
  }
  
  let yandexApiKey = "3f04763a-5272-4f3d-926b-3b2b1fb38e5c"
  

  func getForecast(from: City, completion: @escaping  (Result<Forecast, Error>) -> ()) {
    yandexWeatherURL.query = "?lat = \(from.latitude)&"
    let request = URLRequest(url: yandexWeatherURL)
    
}
}
