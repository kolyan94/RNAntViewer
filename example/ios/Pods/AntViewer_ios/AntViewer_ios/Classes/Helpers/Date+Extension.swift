//
//  Date+Extension.swift
//  viewer-module
//
//  Created by Mykola Vaniurskyi on 12/21/18.
//  Copyright © 2018 Mykola Vaniurskyi. All rights reserved.
//

import Foundation

extension Date {
  
  func timeAgo() -> String {
    let secondsAgo = Int(Date().timeIntervalSince(self))
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    let minute = 60
    let hour = 60 * minute
    let day = 24 * hour
    let week = 7 * day
    
    let quotient: Int
    let unitFormat: String
    if secondsAgo < minute {
      if secondsAgo == 0 {
        return "now"
      }
      quotient = secondsAgo
      unitFormat = "%d s ago"
    } else if secondsAgo < hour {
      quotient = secondsAgo / minute
      unitFormat = "%d m ago"
    } else if secondsAgo < day {
      quotient = secondsAgo / hour
      unitFormat = "%d h ago"
    } else if secondsAgo < week {
      quotient = secondsAgo / day
      unitFormat = "%d d ago"
    } else {
      return dateFormatter.string(from: self)
     }
    
    return String(format: unitFormat, quotient)
  }
}
