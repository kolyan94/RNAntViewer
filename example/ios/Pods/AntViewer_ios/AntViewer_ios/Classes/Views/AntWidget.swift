//
//  AntWidget.swift
//  viewer-module
//
//  Created by Mykola Vaniurskyi on 12/16/18.
//  Copyright © 2018 Mykola Vaniurskyi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
import IQKeyboardManagerSwift

public class AntWidget: UIView {
  let kCONTENT_XIB_NAME = "AntWidget"
  
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var streamNameLabel: UILabel!
  @IBOutlet weak var viewersCountLabel: UILabel!
  
  @IBOutlet weak var antButton: UIButton! {
    didSet {
      antButton.layer.cornerRadius = antButton.bounds.height/2
//      antButton.layer.masksToBounds = true
    }
  }
  @IBOutlet weak var tongueView: UIView!
  @IBOutlet weak var tongueViewWidth: NSLayoutConstraint!
  
  var shownStream: Stream? {
    didSet {
      streamNameLabel.text = shownStream?.title
      if let count = shownStream?.viewersCount {
        viewersCountLabel.text = "\(count) Viewers"
      }
      
      if shownStream != nil {
        tongueView.transform = CGAffineTransform(translationX: 274, y: 0)
        tongueViewWidth.constant = 274
        self.tongueView.isHidden = false
        self.increaseWidgetFrame()
        UIView.animate(withDuration: 0.3, animations: {
          self.tongueView.transform = CGAffineTransform(translationX: 0, y: 0)
          self.tongueView.frame.size.width = 274
          self.tongueView.isHidden = false
          self.tongueView.layoutIfNeeded()
        })
      } else {
        
        UIView.animate(withDuration: 0.3, animations: {
          self.tongueView.transform = CGAffineTransform(translationX: 274, y: 0)
          self.tongueView.frame.size.width = 0
        }) { (value) in
          self.increaseWidgetFrame(false)
          self.tongueViewWidth.constant = 0
          self.tongueView.isHidden = true
          self.tongueView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
      }
    }
  }
  
  func increaseWidgetFrame(_ value: Bool = true) {
    if value {
      var newFrame = initialFrame
      newFrame.size.width += 274
      newFrame.origin.x -= 274
      self.frame = newFrame
    } else {
      self.frame = initialFrame
    }
  
  }
  
  var dataSource: DataSource? {
    didSet {
      dataSource?.startUpdateingStreams()
    }
  }
  
  var shownIds: [Int] {
    set {
      UserDefaults.standard.set(newValue, forKey: "shownIds")
      //MARK: For demo
      guard !shownIds.isEmpty else {return}
      DispatchQueue.global().asyncAfter(deadline: .now() + 11) {
        UserDefaults.standard.set([], forKey: "shownIds")
      }
    }
    get {
      return UserDefaults.standard.array(forKey: "shownIds") as? [Int] ?? []
    }
  }
  
  var watchedVods: [Int] {
    set {
      UserDefaults.standard.set(newValue, forKey: "viewedVods")
    }
    get {
      return UserDefaults.standard.array(forKey: "viewedVods") as? [Int] ?? []
    }
  }
  
  var initialFrame: CGRect = .zero
  
  convenience init() {
    let space: CGFloat = 20
    let height: CGFloat = 75
    let rect = UIScreen.main.bounds
    let newX = rect.width - space - height
    let newY = rect.height - space - height
    self.init(frame: CGRect(x: newX, y: newY, width: height, height: height))

  }
  
  private override init(frame: CGRect) {
    initialFrame = frame
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialFrame = frame
    commonInit()
  }
  
  private func commonInit() {
    Bundle(for: type(of: self)).loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
    contentView.fixInView(self)
    backgroundColor = .clear
    dataSource = DataSource.shared
    NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name(rawValue: "StreamsUpdated"), object: nil)
    
    antButton.setImage(UIImage(named: "Burger", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
    antButton.tintColor = .white
    
    shownStream = nil
    let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
    rightSwipeGesture.direction = .right
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapButton(_:)))
    tongueView.addGestureRecognizer(rightSwipeGesture)
    tongueView.addGestureRecognizer(tapGesture)
    watchedVods = []
    shownIds = []
    
    let filePath = Bundle(for: type(of: self)).path(forResource: "GoogleService-Kek", ofType: "plist")
    guard let fileopts = FirebaseOptions(contentsOfFile: filePath!)
      else { return }
    FirebaseApp.configure(name: "AntViewerFirebase", options: fileopts)
    let app = FirebaseApp.app(name: "AntViewerFirebase")!
    Database.database(app: app).isPersistenceEnabled = true
    setupKeyboard()
  }
  
  func setupKeyboard() {
    IQKeyboardManager.shared.enable = true
    IQKeyboardManager.shared.enableAutoToolbar = false
    IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    IQKeyboardManager.shared.disabledDistanceHandlingClasses = [PlayerController.self]
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()
    antButton.layer.cornerRadius = antButton.bounds.height/2
  }

  @objc
  @IBAction private func didTapButton(_ sender: Any?) {
    guard let vc = findViewController() else {return}
    if let stream = shownStream {
      let playerVC = PlayerController()
      playerVC.videoContent = stream
      vc.present(playerVC, animated: true, completion: nil)
      return
    }
    vc.present(NavigationController(rootViewController: StreamListController(nibName: "StreamListController", bundle: Bundle(for: type(of: self)))), animated: true, completion: nil)

  }

  @objc
  func handleNotification(_ notification: NSNotification) {
    
    guard self.window != nil,
      let streams = dataSource?.streams,
    shownStream == nil else {
      updateAntButton(forLive: dataSource?.streams.isEmpty == false)
      return
    }
    
    let ids = streams.map{$0.id}
    
    for streamId in ids {
      if !shownIds.contains(streamId) {
        shownStream = dataSource?.streams.first(where: {$0.id == streamId})
        shownIds.append(streamId)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
          self?.shownStream = nil
        }
        break
      }
    }
    
    updateAntButton(forLive: !ids.isEmpty)
    
  }
  
  func updateAntButton(forLive: Bool = false) {
    if forLive {
      antButton.addBadge(shape: .rect, text: "Live")
      antButton.setImage(UIImage(named: "Burger", in: Bundle(for: type(of: self)), compatibleWith: nil), for: .normal)
      return
    }
    guard let newVodsCount = dataSource?.videos.filter({!watchedVods.contains($0.id)}).count else {return}
    if newVodsCount > 0 {
      antButton.addBadge(shape: .circle, text: "\(newVodsCount)")
      antButton.setImage(UIImage(named: "Burger", in: Bundle(for: type(of: self)), compatibleWith: nil), for: .normal)
    } else {
      antButton.setImage(UIImage(named: "Burger", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
      antButton.tintColor = .white
      antButton.removeBadge()
    }
  }
  
  @objc
  func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
    shownStream = nil
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
}

extension UIView
{
  func fixInView(_ container: UIView!) {
    self.translatesAutoresizingMaskIntoConstraints = false;
    self.frame = container.frame;
    container.addSubview(self);
    NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
  }
}
