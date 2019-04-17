//
//  AVPlayerView.swift
//  
//
//  Created by Maryan Luchko on 3/13/19.
//

import Foundation
import UIKit
import AVFoundation

class AVPlayerView: UIView {
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
