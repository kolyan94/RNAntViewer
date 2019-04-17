//
//  UIButton+Badge.swift
//  viewer-module
//
//  Created by Mykola Vaniurskyi on 12/17/18.
//  Copyright © 2018 Mykola Vaniurskyi. All rights reserved.
//

import UIKit

enum Shape {
  case circle, rect
}

extension CAShapeLayer {
  fileprivate func drawCircleAtLocation(_ location: CGPoint, withRadius radius: CGFloat, andColor color: UIColor, filled: Bool) {
    fillColor = filled ? color.cgColor : UIColor.white.cgColor
    strokeColor = color.cgColor
    let origin = CGPoint(x: location.x - radius, y: location.y - radius)
    path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))).cgPath
  }
  
  fileprivate func drawRectAtLocation(_ location: CGPoint, withSize size: CGSize, andColor color: UIColor, filled: Bool) {
    fillColor = filled ? color.cgColor : UIColor.white.cgColor
    strokeColor = color.cgColor
    let origin = CGPoint(x: location.x - size.width/2, y: location.y - size.height/2)
    path = UIBezierPath(roundedRect: CGRect(origin: origin, size: size), cornerRadius: 3).cgPath
  }
}

private var handle: UInt8 = 0

extension UIButton {
  
  private var badgeLayer: CAShapeLayer? {
    if let b = objc_getAssociatedObject(self, &handle) {
      return b as? CAShapeLayer
    } else {
      return nil
    }
  }
  
  func addBadge(shape: Shape, text: String, withOffset offset: CGPoint = .zero, andColor color: UIColor = UIColor(red: 0.94, green: 0.44, blue: 0.67, alpha: 1), andFilled filled: Bool = true) {
    
    badgeLayer?.removeFromSuperlayer()
    
    // Initialize Badge
    let badge = CAShapeLayer()
    let radius = text.isEmpty ? CGFloat(5) : CGFloat(7)
    
    let label = CATextLayer()
    label.string = text
    label.alignmentMode = CATextLayerAlignmentMode.center
    label.fontSize = 11
    let width = text.width(withConstrainedHeight: 16, font: label.font as! UIFont)
    
    let location = CGPoint(x: self.frame.width - (radius + offset.x), y: (radius + offset.y))
    if shape == .circle {
      badge.drawCircleAtLocation(location, withRadius: radius, andColor: color, filled: filled)
    } else {
      badge.drawRectAtLocation(location, withSize: CGSize(width: width/2, height: radius * 2), andColor: color, filled: filled)
    }
    
    
    self.layer.addSublayer(badge)
    
    // Initialiaze Badge's label

    label.frame = CGRect(origin: CGPoint(x: location.x - width/2, y: offset.y), size: CGSize(width: width, height: 16))
    label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
    label.backgroundColor = UIColor.clear.cgColor
    label.contentsScale = UIScreen.main.scale
    badge.addSublayer(label)
    
    // Save Badge as UIBarButtonItem property
    objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
  
  func updateBadge(number: Int) {
    if let text = badgeLayer?.sublayers?.filter({ $0 is CATextLayer }).first as? CATextLayer {
      text.string = number == 0 ? "" : "\(number)"
    }
  }
  
  func removeBadge() {
    badgeLayer?.removeFromSuperlayer()
  }
  
}

extension String {
  //FIXME: 
  func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
    return ceil(boundingBox.width)
  }
  
}
