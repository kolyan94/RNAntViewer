//
//  Message.swift
//  viewer-module
//
//  Created by Mykola Vaniurskyi on 12/7/18.
//  Copyright © 2018 Mykola Vaniurskyi. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Message {
  
  var key: String
  let timestamp: Int
  let email: String
  let nickname: String
  let text: String
  let avatarUrl: String?
  
  init(timestamp: Int = Int(Date().timeIntervalSince1970), email: String = "", nickname: String? = nil, text: String , key: String = "", avatarUrl: String? = nil) {
    self.key = key
    self.timestamp = timestamp
    self.email = email
    self.nickname = nickname ?? email
    self.text = text
    self.avatarUrl = avatarUrl
  }
  
  init?(snapshot: DataSnapshot) {
    guard
      let value = snapshot.value as? [String: AnyObject],
      let type = value["type"] as? Int,
      type == 1,
      let timestamp = value["timestamp"] as? Int,
      let nickname = value["nickname"] as? String?,
      let email = value["email"] as? String?,
      let text = value["text"] as? String,
      let avatarUrl = value["avatarUrl"] as? String? else {
        return nil
    }
    
    self.key = snapshot.key
    self.timestamp = timestamp
    self.email = email ?? ""
    self.nickname = nickname ?? ""
    self.text = text
    self.avatarUrl = avatarUrl
  }
  
  func toAnyObject() -> [String: Any?] {
    return [
      "avatarUrl": avatarUrl,
      "type": 1,
      "timestamp": timestamp,
      "email": email,
      "nickname": nickname,
      "text": text
    ]
  }
  
}
