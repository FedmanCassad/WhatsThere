//
//  WeedayToStringConverter.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 08.03.2021.
//

import Foundation

extension String {
  mutating func convertToLocalWeekday() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: "ru_RU")
    guard let date = dateFormatter.date(from: self) else {return}
    dateFormatter.dateFormat = "EEEE"
    var weekday = dateFormatter.string(from: date)
    weekday.capitalizeFirstLetter()
    self = weekday
  }
}
