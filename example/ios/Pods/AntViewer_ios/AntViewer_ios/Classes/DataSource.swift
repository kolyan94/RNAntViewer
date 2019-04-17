//
//  DataSource.swift
//  viewer-module
//
//  Created by Mykola Vaniurskyi on 12/12/18.
//  Copyright © 2018 Mykola Vaniurskyi. All rights reserved.
//

import Foundation

//MARK: Fake data
private let startDate = Date(timeIntervalSince1970: 1545264000) // 12/20/2018
private let oneDay: Double = 60*60*24

private let baseUrl = "http://18.185.126.11:1935/vod/"
private let vods = [
Video(id: 1, title: "Inside England, with Vauxhall", creatorName: "Heading Out for Training", creatorNickname: "", creatorId: 0, url: "\(baseUrl)1. The lads are heading out to training.mp4/playlist.m3u8".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, date:Date() , viewersCount: 13553, duration: 30),
Video(id: 2, title: "Roommates with Head and Shoulders", creatorName: "Kyle Walker and John Stones", creatorNickname: "", creatorId: 1, url: "\(baseUrl)2. Roommates.mp4/playlist.m3u8".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, date: Date(timeIntervalSinceNow: -3000), viewersCount: 14555, duration: 19),
Video(id: 3, title: "Live Coverage", creatorName: "England Women vs Sweden Women", creatorNickname: "", creatorId: 0, url: "\(baseUrl)3. England v Sweden LIVE.mp4/playlist.m3u8".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, date: Date(timeInterval: -oneDay, since: startDate), viewersCount: 14235, duration: 26),
Video(id: 4, title: "Stars of the Future with Nike", creatorName: "U21 5-a-side game", creatorNickname: "", creatorId: 0, url: "\(baseUrl)4. England U21 5_a_side.mp4/playlist.m3u8".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, date: Date(timeInterval: -oneDay*2, since: startDate), viewersCount: 4324, duration: 19),
Video(id: 5, title: "SupporterReporter", creatorName: "Penalties vs Columbia", creatorNickname: "", creatorId: 0, url: "\(baseUrl)5. #SupporterReporter vs Columbia.mp4/playlist.m3u8".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, date: Date(timeInterval: -oneDay*3, since: startDate), viewersCount: 54354, duration: 29),
Video(id: 6, title: "Media Day with M&S", creatorName: "The squad has been selected", creatorNickname: "", creatorId: 0, url: "\(baseUrl)6. Media Day.mp4/playlist.m3u8".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, date: Date(timeInterval: -oneDay*4, since: startDate), viewersCount: 234, duration: 35),
Video(id: 7, title: "Bud Light’s Alternative Commentary", creatorName: "FT Reev and Theo Baker", creatorNickname: "", creatorId: 0, url: "\(baseUrl)7. Alternative Commentary, FT Reev and Theo Baker.mp4/playlist.m3u8".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, date: Date(timeInterval: -oneDay*6, since: startDate), viewersCount: 123, duration: 40)
]

private var randomInt: Int {
  return [1, 2, 2, 1, 4, 6, 1, 3, 2, 5, 7].randomElement() ?? 1
}

class DataSource {
  
  static let shared = DataSource()
  private init() {}
  
  fileprivate var timer: Timer?
  var streams = [Stream]()
  var videos = vods
  
}

extension DataSource {
  
  func startUpdateingStreams() {
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 6, repeats: true, block: { [weak self] (myTimer) in
      GetAllStreams().execute(onSuccess: { (newStreams) in
        self?.streams = newStreams.map { newStream in
          guard let oldStream = self?.streams.first(where: {$0.id == newStream.id}) else {return newStream}
          var stream = newStream
          stream.viewersCount = oldStream.viewersCount + randomInt
          return stream
        }.reversed()
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "StreamsUpdated"), object: nil)
        }, onError: { (error) in
          print("Stream update error: \(error.localizedDescription)")
      })
      
    })
  }
}
