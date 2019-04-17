//
//  DateFormatter+Extension.swift
//  viewer-module
//
//  Created by Mykola Vaniurskyi on 12/13/18.
//  Copyright © 2018 Mykola Vaniurskyi. All rights reserved.
//

import Foundation

extension Formatter {
  static let iso8601: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return formatter
  }()
  static let iso8601noFS = ISO8601DateFormatter()
}

extension JSONDecoder.DateDecodingStrategy {
  static let customISO8601 = custom { decoder throws -> Date in
    let container = try decoder.singleValueContainer()
    let string = try container.decode(String.self)
    if let date = Formatter.iso8601.date(from: string + "Z") ?? Formatter.iso8601noFS.date(from: string + "Z") {
      return date
    }
    throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
  }
}
