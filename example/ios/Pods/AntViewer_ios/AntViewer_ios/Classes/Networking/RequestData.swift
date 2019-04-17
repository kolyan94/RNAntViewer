//
//  RequestData.swift
//  viewer-module
//
//  Created by Mykola Vaniurskyi on 12/12/18.
//  Copyright © 2018 Mykola Vaniurskyi. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
  case patch = "PATCH"
}

struct RequestData {
  let path: String
  let method: HTTPMethod
  let params: [String: Any?]?
  let headers: [String: String]?
  
  init (
    path: String,
    method: HTTPMethod = .get,
    params: [String: Any?]? = nil,
    headers: [String: String]? = nil
    ) {
    self.path = path
    self.method = method
    self.params = params
    self.headers = headers
  }
}

protocol RequestType {
  associatedtype ResponseType: Codable
  var data: RequestData { get }
}

extension RequestType {
  public func execute (
    dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
    onSuccess: @escaping (ResponseType) -> Void,
    onError: @escaping (Error) -> Void
    ) {
    dispatcher.dispatch(
      request: self.data,
      onSuccess: { (responseData: Data) in
        do {
          let jsonDecoder = JSONDecoder()
          jsonDecoder.dateDecodingStrategy = .customISO8601
          let result = try jsonDecoder.decode(ResponseType.self, from: responseData)
          DispatchQueue.main.async {
            onSuccess(result)
          }
        } catch let error {
          DispatchQueue.main.async {
            onError(error)
          }
        }
    },
      onError: { (error: Error) in
        DispatchQueue.main.async {
          onError(error)
        }
    }
    )
  }
}

