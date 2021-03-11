//
//  IconsCache.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 11.03.2021.
//

import UIKit
import SVGKit

protocol IconsStorage: AnyObject {
  var localIconsProvider: Dictionary<String, UIImage> { get set }
  func getTheIconFromStorage(iconString: String) -> UIImage?
  func saveIconToStorage(iconString: String, image: UIImage)
}

class IconsCache: IconsStorage {
  var localIconsProvider: Dictionary<String, UIImage> = [String: UIImage]()
  
  func getTheIconFromStorage(iconString: String) -> UIImage? {
    guard let image = localIconsProvider[iconString] else { return nil }
    return image
  }
  
  func saveIconToStorage(iconString: String, image: UIImage) {
    localIconsProvider[iconString] = image
  }
  
  init(fetchIconsFrom forecasts: [YandexForecast]) {
    fetchIcons(from: forecasts)
  }
  
  private func fetchIcons(from forecasts: [YandexForecast]) {
    for commonForecast in forecasts {
      let iconString = commonForecast.currentWeather.icon
      if localIconsProvider[iconString] == nil {
        let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(iconString).svg")
        let image = SVGKImage(contentsOf: url)
        localIconsProvider[iconString] = image?.uiImage
        for dayForecast in  commonForecast.nextDaysForecasts {
          let anotherIconSting = dayForecast.partialForecast.day.icon
          if localIconsProvider[anotherIconSting] == nil {
            let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(anotherIconSting).svg")
            let anotherImage = SVGKImage(contentsOf: url)
            localIconsProvider[anotherIconSting] = anotherImage?.uiImage
          }
        }
      }
    }
  }
}
