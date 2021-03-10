//
//  CityCoordinates.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 07.03.2021.
//

import Foundation

protocol Locatable {
  var latitude: Double { get }
  var longitude: Double { get }
}

struct City: Locatable {
  var cityName: String
  var latitude: Double
  var longitude: Double
}
