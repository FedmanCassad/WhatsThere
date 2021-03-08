//
//  FirstCharacterCapitalizer.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 08.03.2021.
//

import Foundation
extension String {
  private func capitalizingFirstLetter() -> String {
          return prefix(1).capitalized + dropFirst()
      }

      mutating func capitalizeFirstLetter() {
          self = self.capitalizingFirstLetter()
      }
}
