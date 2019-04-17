//
//  VideoContent.swift
//  viewer-module
//
//  Created by Mykola Vaniurskyi on 12/5/18.
//  Copyright © 2018 Mykola Vaniurskyi. All rights reserved.
//

import Foundation

protocol VideoContent {
  
  var id: Int {get}
  var title: String {get}
  var url: String {get}
  var creatorName: String {get}
  var creatorNickname: String {get}
  var thumbnailUrl: String {get}
  var creatorId: Int {get}
  var date: Date {get}
  var viewersCount: Int {get set}
  
}

struct Stream: VideoContent {
  
  let id: Int
  let title: String
  var creatorName = ""
  let creatorNickname: String
  let thumbnailUrl: String
  let creatorId: Int
  let url: String
  let date: Date
  var viewersCount = 0
  
}

extension Stream: Codable {
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title = "name"
    case creatorName = "creatorFullName"
    case creatorNickname
    case thumbnailUrl
    case creatorId
    case url = "hlsUrl"
    case date = "startTime"
  }
  
}

struct Video: VideoContent {
  
  let id: Int
  let title: String
  var creatorName = ""
  let creatorNickname: String
  var thumbnailUrl: String {
    return "kek"
  }
  let creatorId: Int
  let url: String
  let date: Date
  var viewersCount = 0
  let duration: Int
  
}

extension Int {
  var durationString: String {
    let minute = 60
    let hour = 60 * minute
    
    if self < hour {
      return "\(self%hour/minute):\(String(format: "%02d", self%minute))"
    } else {
      return "\(self/hour):\(String(format: "%02d", self%hour/minute)):\(String(format: "%02d", self%minute))"
    }
  }
}
