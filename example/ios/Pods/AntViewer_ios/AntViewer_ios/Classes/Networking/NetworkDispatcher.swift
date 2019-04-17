//
//  NetworkDispatcher.swift
//  viewer-module
//
//  Created by Mykola Vaniurskyi on 12/12/18.
//  Copyright © 2018 Mykola Vaniurskyi. All rights reserved.
//

import Foundation

enum ConnError: Swift.Error {
  case invalidURL
  case noData
}

protocol NetworkDispatcher {
  func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void)
}

struct URLSessionNetworkDispatcher: NetworkDispatcher {
  static let instance = URLSessionNetworkDispatcher()
  private init() {}
  
  func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {
    guard let url = URL(string: request.path) else {
      onError(ConnError.invalidURL)
      return
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    
    do {
      if let params = request.params {
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
      }
    } catch let error {
      onError(error)
      return
    }
    
    if let headers = request.headers {
      urlRequest.allHTTPHeaderFields = headers
    }
    
    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      if let error = error {
        onError(error)
        return
      }
      
      guard let _data = data else {
        onError(ConnError.noData)
        return
      }
      
      onSuccess(_data)
      }.resume()
  }
}
