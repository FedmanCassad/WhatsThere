//
//  UIColor+UiColorFromHexString.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 07.03.2021.
//

import UIKit

extension UIColor {
  
  static func UIColorFromHex (hex: String) -> UIColor? {
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    if ((cString.count) != 8) {
      return nil
    }
    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    let r = CGFloat((rgbValue & 0xff000000) >> 24) / 255
    let  g = CGFloat((rgbValue & 0x00ff0000) >> 16) / 255
    let  b = CGFloat((rgbValue & 0x0000ff00) >> 8) / 255
    let  a = CGFloat(rgbValue & 0x000000ff) / 255
    return UIColor(red: r, green: g, blue: b, alpha: a)
  }
}

