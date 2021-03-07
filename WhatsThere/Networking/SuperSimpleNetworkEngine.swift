//
//  GeocoderService.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 06.03.2021.
//

import UIKit

final class SuperSimpleNetworkEngine {
  
  var session: URLSession {
    URLSession.shared
  }
  
  enum Scheme: String {
    case https = "https"
  }
  
  enum Host: String {
    case yandexWeather = "api.weather.yandex.ru"
  }
  
  enum Destination: String {
  case forecast = "/v2/forecast"
  }
  
  let yandexApiKey = "3f04763a-5272-4f3d-926b-3b2b1fb38e5c"
  
  func constructForecastRequest(for city: City) -> URLRequest? {
    let components: URLComponents = {
      var components = URLComponents()
      components.scheme = Scheme.https.rawValue
      components.host = Host.yandexWeather.rawValue
      components.path = Destination.forecast.rawValue
      components.queryItems = [
        URLQueryItem(name: "lat", value: String(city.latitude)),
        URLQueryItem(name: "lon", value: String(city.longitude)),
        URLQueryItem(name: "limit", value: "7"),
        URLQueryItem(name: "lang", value: "ru_RU")
      ]
      return components
    }()
    guard let url = components.url else {
      return nil
    }
    
    var request = URLRequest(url: url)
    request.addValue(yandexApiKey, forHTTPHeaderField: "X-Yandex-API-Key")
    return request
  }

  func getForecast(from city: City, completion: @escaping  (Result<RecievedForecast?, ForecastError>) -> ()) {
//    yandexWeatherURL.query = "?lat = \(from.latitude)&"
    guard let request = constructForecastRequest(for: city) else {
      completion(.failure(.cantGenerateRequest))
      return
    }
    
    session.dataTask(with: request) {data, response, error in
      if let error = error {
        assertionFailure(error.localizedDescription)
        completion(.failure(.requestError(errorCode: response as! HTTPURLResponse)))
      }
      if let data = data {
        let forecast = try? JSONDecoder().decode(RecievedForecast.self, from: data)
        completion(.success(forecast))
      }
    }.resume()
}
  
}
