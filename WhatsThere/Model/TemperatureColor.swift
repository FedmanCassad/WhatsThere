//
//  MainCellColors.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 08.03.2021.
//

import UIKit

enum TemperatureColor {
  case colorDepending(onTemperatureValue: Int)
  
  var color: UIColor {
    switch self {
      case .colorDepending(onTemperatureValue: let value):
        switch value {
          case 32 ..< 38:
            return UIColor(red: 0.76, green: 0.00, blue: 0.00, alpha: 1.00)
          case 27 ..< 32:
            return UIColor(red: 0.87, green: 0.00, blue: 0.00, alpha: 1.00)
          case 21 ..< 27:
            return  UIColor(red: 1.00, green: 0.03, blue: 0.03, alpha: 1.00)
          case 16 ..< 21:
            return UIColor(red: 1.00, green: 0.56, blue: 0.19, alpha: 1.00)
          case 10 ..< 16:
            return UIColor(red: 1.00, green: 0.75, blue: 0.00, alpha: 1.00)
          case 4 ..< 10:
            return UIColor(red: 0.49, green: 0.83, blue: 0.19, alpha: 1.00)
          case -1 ..< 4:
            return UIColor(red: 0.00, green: 0.70, blue: 0.26, alpha: 1.00)
          case -7 ..< -1:
            return UIColor(red: 0.00, green: 0.61, blue: 1.00, alpha: 1.00)
          case -12 ..< -7:
            return UIColor(red: 0.20, green: 0.20, blue: 1.00, alpha: 1.00)
          case -18 ..< -12:
            return UIColor(red: 0.47, green: 0.17, blue: 0.66, alpha: 1.00)
          case -23 ..< -18:
            return UIColor(red: 0.65, green: 0.00, blue: 0.62, alpha: 1.00)
          case -Int.max ..< -23:
            return UIColor(red: 0.87, green: 0.00, blue: 0.62, alpha: 1.00)
          default:
            return .red
        }
    }
  }
}
