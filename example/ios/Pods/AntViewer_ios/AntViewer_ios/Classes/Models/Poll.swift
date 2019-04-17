//
//  Poll.swift
//  viewer-module
//
//  Created by Mykola Vaniurskyi on 12/17/18.
//  Copyright © 2018 Mykola Vaniurskyi. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Poll {
  
  var ref: DatabaseReference?
  var key: String
  let streamId: Int
  let teamId: Int
  let userId: Int
  var answeredByUser: Bool
  let isActive: Bool
  let pollQuestion: String
  var pollAnswers: [(String, [String: String])]
  var percentForEachAnswer: [Int] {
    return Poll.calculatePercentages(pollAnswers.map {$0.1.count})
  }
  
  init?(snapshot: DataSnapshot) {
    guard
      let value = snapshot.value as? [String: AnyObject],
      let teamId = value["teamId"] as? Int,
      let userId = value["userId"] as? Int,
      let streamId = value["userId"] as? Int,
      let pollQuestion = value["pollQuestion"] as? String,
      let pollAnswers = value["pollAnswers"] as? [[String: AnyObject]] else {
        return nil
    }
    
    let parsedPollAnswers = pollAnswers.map {($0["answerText"] as? String ?? "", $0["answeredUsers"] as? [String: String] ?? [String: String]())}
    self.ref = snapshot.ref
    self.key = snapshot.key
    self.teamId = teamId
    self.userId = userId
    self.streamId = streamId
    self.pollQuestion = pollQuestion
    self.pollAnswers = parsedPollAnswers
    let name = UserDefaults.standard.string(forKey: "userName") ?? "SuperFan123"
    self.answeredByUser = parsedPollAnswers.contains(where: { dict in dict.1.contains(where: {$0.value == name})})
    self.isActive = value["isActive"]?.boolValue == true
  }
  
  //MARK: Just skip it :)
  private static func calculatePercentages(_ pollAnswers: [Int]) -> [Int] {
    let sum = pollAnswers.reduce(0, +)
    if sum == 0 {
      return pollAnswers
    }
    let percentageArray = pollAnswers.map {100 * $0/sum}
    let arrayWithoutZero = percentageArray.filter {$0 != 0}
    let delta = percentageArray.reduce(100, -)
    if Set(arrayWithoutZero).count == 1 {
      return percentageArray
    }
    let firstElement = arrayWithoutZero[0]
    let number = arrayWithoutZero.dropFirst().contains(firstElement) ? arrayWithoutZero.first(where: {$0 != firstElement}) ?? firstElement : firstElement
    let count = arrayWithoutZero.filter {$0 == number}.count
    let a = delta/count
    return percentageArray.map {$0 == number ? $0 + a : $0}
  }
  
}


