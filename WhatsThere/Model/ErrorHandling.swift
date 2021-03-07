//
//  ErrorHandling.swift
//  WhatsThere
//
//  Created by Vladimir Banushkin on 07.03.2021.
//

import Foundation

public enum ForecastError: Error {
  case cantGenerateRequest
  case requestError(errorCode: HTTPURLResponse)
  var description: (String, String) {
    switch self {
      case
        .cantGenerateRequest:
        return ("Can't make a URLRequest", "Try again")
      case .requestError(let errorCode):
        switch errorCode.statusCode {
          case 404:
            return ("404", "Not found")
          case 400:
            return ("400", "Bad request")
          case 401:
            return ("401", "Unauthorized")
          case 406:
            return ("406", "Not acceptable")
          case 422:
            return ("422", "Unprocessable")
          default:
            return ("Unknown error", "Unknown error")
        }
    }
  }
}
