//
//  AVPlayer+Extension.swift
//  viewer-module
//
//  Created by Mykola Vaniurskyi on 12/21/18.
//  Copyright © 2018 Mykola Vaniurskyi. All rights reserved.
//

import AVKit

extension AVPlayer {
  
  var isPlaying: Bool {
    return rate != 0 && error == nil
  }
  
}
