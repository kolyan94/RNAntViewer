//
//  GetAllStreams.swift
//  viewer-module
//
//  Created by Mykola Vaniurskyi on 12/12/18.
//  Copyright © 2018 Mykola Vaniurskyi. All rights reserved.
//

import Foundation

struct GetAllStreams: RequestType {
  typealias ResponseType = [Stream]
  var data: RequestData {
    guard let host = UserDefaults.standard.string(forKey: "host") else {
      return RequestData(path: "https://staging-myra.com/api/v1/channels/live")
    }
//    if UserDefaults.standard.bool(forKey: "isTestMode") {
//      return RequestData(path: "https://api-myra.net/api/v1/channels/liveV2")
//    }
//    return RequestData(path: "http://antourage.com/api/v1/channels/liveV2")
    return RequestData(path: host)
    
    
//    return RequestData(path: "https://staging-myra.com/api/v1/channels/liveV2")
  }
}
