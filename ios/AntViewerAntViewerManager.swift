//
//  AntViewer.swift
//  RNAntViewer
//
//  Created by Mykola Vaniurskyi on 5/2/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import UIKit
import AntViewer_ios

@objc(AntViewerManager)
class AntViewerManager : RCTViewManager {
  override func view() -> UIView! {
    return AntWidget();
  }
}

