//
//  Forecast.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 07.03.2021.
//

import Foundation

struct YandexForecast: Codable {
  
  let info: Info
  let cityObject: GeoObject
  let currentWeather: CurrentWeather
  let nextDaysForecasts: [Forecast]
  
  enum CodingKeys: String, CodingKey {
    case cityObject = "geo_object"
    case currentWeather = "fact"
    case nextDaysForecasts = "forecasts"
    case info
  }
  
  struct GeoObject: Codable {
    let locality, province, country: GeoDescription
    
    struct GeoDescription: Codable {
      let id: Int
      let name: String
    }
  }
  
  struct Info: Codable {
    let lat, lon: Double
    enum CodingKeys: String, CodingKey {
      case lat, lon
    }
  }
  
  struct CurrentWeather: Codable {
    let temp, feelsLike: Int
    let icon: String
    enum CodingKeys: String, CodingKey {
      case temp = "temp"
      case feelsLike = "feels_like"
      case icon
    }
  }
  struct Forecast: Codable {
    let date: String
    let partialForecast: PartialForecast
    
    struct PartialForecast: Codable {
      let dayShortForecast: DayShortForecast
      let day: FullDayForecast
      enum CodingKeys: String, CodingKey {
        case dayShortForecast = "day_short"
        case day = "day"
      }
      
      struct FullDayForecast: Codable {
        let minimumTemp, maximumTemp, humidity: Int
        enum CodingKeys: String, CodingKey {
          case minimumTemp = "temp_min"
          case maximumTemp = "temp_max"
          case humidity
        }
      }
      struct DayShortForecast: Codable {
        let temp: Int
        let icon: String
        enum CodingKeys: String, CodingKey {
          case temp, icon
        }
      }
    }
    
    enum CodingKeys: String, CodingKey {
      case date
      case partialForecast = "parts"
    }
  }
}







