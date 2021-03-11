//
//  GeocoderService.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 06.03.2021.
//

import UIKit

protocol WeatherFetcher {
  func getForecast(from city: City, completion: @escaping  (Result<YandexForecast, ForecastError>) -> ())
}

final class SuperSimpleNetworkEngine: WeatherFetcher {
  
  private let yandexApiKey = "3f04763a-5272-4f3d-926b-3b2b1fb38e5c"
  private var session: URLSession {
    URLSession.shared
  }
  
  //MARK: -  Simplest network layer
  private func constructForecastRequest(for city: City) -> URLRequest? {
    let components: URLComponents = {
      var components = URLComponents()
      components.scheme = "https"
      components.host = "api.weather.yandex.ru"
      components.path = "/v2/forecast"
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
  
  func getForecast(from city: City, completion: @escaping  (Result<YandexForecast, ForecastError>) -> ()) {
    let dispatchGroup = DispatchGroup()
    guard let request = constructForecastRequest(for: city) else {
      completion(.failure(.cantGenerateRequest))
      return
    }
    dispatchGroup.enter()
      session.dataTask(with: request) {data, response, error in
        print("Вызываю сервис в - \(Thread.current)")
      if let error = error {
        assertionFailure(error.localizedDescription)
        completion(.failure(.requestError(errorCode: response as! HTTPURLResponse)))
      }
      if let data = data {
        if let forecast = try? JSONDecoder().decode(YandexForecast.self, from: data) {
        
          completion(.success(forecast))
          dispatchGroup.leave()
          
        } else {
          completion(.failure(.parseError))
          dispatchGroup.leave()
        }
      }
    
    }.resume()
    
  }
}
