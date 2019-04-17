//
//  Debouncer.swift
//  viewer-module
//
//  Created by Mykola Vaniurskyi on 12/16/18.
//  Copyright © 2018 Mykola Vaniurskyi. All rights reserved.
//

import Foundation

class Debouncer: NSObject {
  
  var delay: Double
  weak var timer: Timer?
  var foo: (() -> ())?
  
  init(delay: Double) {
    self.delay = delay
  }
  
  func call( _ funcToCall: @escaping () -> () ) {
    timer?.invalidate()
    self.foo = funcToCall
    let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(self.execute), userInfo: nil, repeats: false)
    timer = nextTimer
  }
  
  @objc func execute() {
    if foo != nil {
        self.foo!()
    }
  }
  
}
