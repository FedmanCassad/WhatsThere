//
//  Forecast.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 07.03.2021.
//

import Foundation

struct RecievedForecast: Codable {
  // This file was generated from JSON Schema using quicktype, do not modify it directly.
  // To parse the JSON, add this file to your project and do:
  //
  //   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
  
  //
  //      let now: Int
  //      let nowDt: String
  //      let info: Info
  //      let geoObject: GeoObject
  //      let yesterday: Yesterday
  //      let fact: Fact
  ////      let forecasts: [Forecast]
  //
  //      enum CodingKeys: String, CodingKey {
  //          case now
  //          case nowDt = "now_dt"
  //          case info
  //          case geoObject = "geo_object"
  //          case yesterday, fact
  //      }
  //  }
  //
  //  // MARK: - Fact
  //  struct Fact: Codable {
  //      let obsTime, uptime, temp: Int?
  //      let feelsLike: Int
  //      let icon: String
  //      let condition: Condition
  //      let cloudness: Double
  //      let precType, precProb: Int
  //      let precStrength: Double
  //      let isThunder: Bool?
  //      let windSpeed: Double
  //      let windDir: WindDir
  //      let pressureMm, pressurePa, humidity: Int
  //      let daytime: String?
  //      let polar: Bool?
  //      let season, factSource: String?
  //      let soilMoisture: Double
  //      let soilTemp, uvIndex: Int
  //      let windGust: Double
  //      let hour: String?
  //      let hourTs: Int?
  //      let precMm: Double?
  //      let precPeriod: Int?
  //      let source: String?
  //      let tempMin, tempAvg, tempMax: Int?
  //
  //      enum CodingKeys: String, CodingKey {
  //          case obsTime = "obs_time"
  //          case uptime, temp
  //          case feelsLike = "feels_like"
  //          case icon, condition, cloudness
  //          case precType = "prec_type"
  //          case precProb = "prec_prob"
  //          case precStrength = "prec_strength"
  //          case isThunder = "is_thunder"
  //          case windSpeed = "wind_speed"
  //          case windDir = "wind_dir"
  //          case pressureMm = "pressure_mm"
  //          case pressurePa = "pressure_pa"
  //          case humidity, daytime, polar, season
  //          case factSource = "source"
  //          case soilMoisture = "soil_moisture"
  //          case soilTemp = "soil_temp"
  //          case uvIndex = "uv_index"
  //          case windGust = "wind_gust"
  //          case hour
  //          case hourTs = "hour_ts"
  //          case precMm = "prec_mm"
  //          case precPeriod = "prec_period"
  //          case source = "_source"
  //          case tempMin = "temp_min"
  //          case tempAvg = "temp_avg"
  //          case tempMax = "temp_max"
  //      }
  //  }
  //
  //  enum Condition: String, Codable {
  //      case cloudy = "cloudy"
  //      case lightSnow = "light-snow"
  //      case overcast = "overcast"
  //  }
  //
  //  enum WindDir: String, Codable {
  //      case e = "e"
  //      case se = "se"
  //  }
  //
  //  // MARK: - Forecast
  //  struct Forecast: Codable {
  //      let date: String
  //      let dateTs, week: Int
  //      let sunrise, sunset, riseBegin, setEnd: String
  //      let moonCode: Int
  //      let moonText: String
  //      let parts: Parts
  //      let hours: [Fact]
  //      let biomet: Biomet
  //
  //      enum CodingKeys: String, CodingKey {
  //          case date
  //          case dateTs = "date_ts"
  //          case week, sunrise, sunset
  //          case riseBegin = "rise_begin"
  //          case setEnd = "set_end"
  //          case moonCode = "moon_code"
  //          case moonText = "moon_text"
  //          case parts, hours, biomet
  //      }
  //  }
  //
  //  // MARK: - Biomet
  //  struct Biomet: Codable {
  //      let index: Int
  //      let condition: String
  //  }
  //
  //  // MARK: - Parts
  //  struct Parts: Codable {
  //      let night, day, evening, morning: Fact
  //      let nightShort, dayShort: Fact
  //
  //      enum CodingKeys: String, CodingKey {
  //          case night, day, evening, morning
  //          case nightShort = "night_short"
  //          case dayShort = "day_short"
  //      }
  //  }
  //
  //  // MARK: - GeoObject
  //  struct GeoObject: Codable {
  //      let district: JSONNull?
  //      let locality, province, country: Country
  //  }
  //
  //  // MARK: - Country
  //  struct Country: Codable {
  //      let id: Int
  //      let name: String
  //  }
  //
  //  // MARK: - Info
  //  struct Info: Codable {
  //      let n: Bool
  //      let geoid: Int
  //      let url: String
  //      let lat, lon: Double
  //      let tzinfo: Tzinfo
  //      let defPressureMm, defPressurePa: Int
  //      let slug: String
  //      let zoom: Int
  //      let nr, ns, nsr, p: Bool
  //      let f, h: Bool
  //
  //      enum CodingKeys: String, CodingKey {
  //          case n, geoid, url, lat, lon, tzinfo
  //          case defPressureMm = "def_pressure_mm"
  //          case defPressurePa = "def_pressure_pa"
  //          case slug, zoom, nr, ns, nsr, p, f
  //          case h = "_h"
  //      }
  //  }
  //
  //  // MARK: - Tzinfo
  //  struct Tzinfo: Codable {
  //      let name, abbr: String
  //      let dst: Bool
  //      let offset: Int
  //  }
  //
  //  // MARK: - Yesterday
  //  struct Yesterday: Codable {
  //      let temp: Int
  //  }
  //
  //  // MARK: - Encode/decode helpers
  //
  //  class JSONNull: Codable, Hashable {
  //
  //      public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
  //          return true
  //      }
  //
  //      public var hashValue: Int {
  //          return 0
  //      }
  //
  //      public func hash(into hasher: inout Hasher) {
  //          // No-op
  //      }
  //
  //      public init() {}
  //
  //      public required init(from decoder: Decoder) throws {
  //          let container = try decoder.singleValueContainer()
  //          if !container.decodeNil() {
  //              throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
  //          }
  //      }
  //
  //      public func encode(to encoder: Encoder) throws {
  //          var container = encoder.singleValueContainer()
  //          try container.encodeNil()
  //      }
  //  }
  
  let info: Info
  let geoObject: GeoObject
  let fact: Fact
  let forecasts: [Forecast]
  
  enum CodingKeys: String, CodingKey {
    case geoObject = "geo_object"
    case info, fact, forecasts
  }
  
  struct GeoObject: Codable {
    let locality, province, country: GeoDescription
    
    struct GeoDescription: Codable {
      let id: Int
      let name: String
    }
  }
}

struct Info: Codable {
  let lat, lon: Double
  enum CodingKeys: String, CodingKey {
    case lat, lon
  }
}

struct Fact: Codable {
  let temp, feelsLike: Int
  enum CodingKeys: String, CodingKey {
    case temp = "temp"
    case feelsLike = "feels_like"
  }
  
  struct Forecast: Codable {
    
  }
}








