//
//  UIView+Extension.swift
//  viewer-module
//
//  Created by Mykola Vaniurskyi on 12/16/18.
//  Copyright © 2018 Mykola Vaniurskyi. All rights reserved.
//

import UIKit
import Lottie

extension UIView {
  
  func findViewController() -> UIViewController? {
    if let nextResponder = self.next as? UIViewController {
      return nextResponder
    } else if let nextResponder = self.next as? UIView {
      return nextResponder.findViewController()
    } else {
      return nil
    }
  }
  
  func showActivityIndicator() {
    removeActivityIndicator()
    let animationView = AnimationView(name: "loader")
    animationView.loopMode = .loop
    addSubview(animationView)
    animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    animationView.translatesAutoresizingMaskIntoConstraints = false
    let horizontalConstraint = NSLayoutConstraint(item: animationView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
    let verticalConstraint = NSLayoutConstraint(item: animationView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
    addConstraints([horizontalConstraint, verticalConstraint])
    animationView.play()
    
  }
  
  func removeActivityIndicator() {
    guard let animationView = subviews.first(where: {$0 is AnimationView}) else {return}
    animationView.removeFromSuperview()
  }
  
}

