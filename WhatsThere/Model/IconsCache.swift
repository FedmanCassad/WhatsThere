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
    let queue = DispatchQueue(label: "com.BroSquad.WhatsThere", qos: .userInteractive, attributes: .concurrent)
    queue.async { [weak self] in
    for commonForecast in forecasts {
      let iconString = commonForecast.currentWeather.icon
      if self?.localIconsProvider[iconString] == nil {
        let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(iconString).svg")
        let image = SVGKImage(contentsOf: url)
        self?.localIconsProvider[iconString] = image?.uiImage
        for dayForecast in  commonForecast.nextDaysForecasts {
          let anotherIconSting = dayForecast.partialForecast.day.icon
          if self?.localIconsProvider[anotherIconSting] == nil {
            let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(anotherIconSting).svg")
            let anotherImage = SVGKImage(contentsOf: url)
            self?.localIconsProvider[anotherIconSting] = anotherImage?.uiImage
          }
        }
      }
    }
    }
  }
}
