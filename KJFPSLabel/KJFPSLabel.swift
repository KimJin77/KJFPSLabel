//
//  KJFPSLabel.swift
//  KJFPSLabel
//
//  Created by Kim on 2018/1/8.
//  Copyright © 2018年 Kim. All rights reserved.
//

import UIKit

class KJFPSMonitor {
    static let shared =  KJFPSMonitor()
    private let fpsLabel = KJFPSLabel()
    
    // MARK: - Actions
    func start() {
        if let app = UIApplication.shared.delegate, let window = app.window {
            window?.addSubview(fpsLabel)
            window?.bringSubview(toFront: fpsLabel)
            fpsLabel.start()
        }
    }
    
    func stop() {
        fpsLabel.stop()
    }
}

class KJFPSLabel: UILabel {
    
    // MARK - Properties
    private static let kRect = CGRect(x: 40, y: 100, width: 60, height: 20)
    private var displayLink: CADisplayLink!
    private var historyCount: Int = 0
    private var lastUpdateTimestamp: Double = 0
    private var fps = 0
    private var pan: UIPanGestureRecognizer?
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        var f = frame;
        if (f.size.width == 0 && f.size.height == 0) {
            f = KJFPSLabel.kRect
        }
        super.init(frame: f)
        self.textAlignment = NSTextAlignment.center
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.font = UIFont(name: "Menlo", size: 12)
        self.isUserInteractionEnabled = true
        
        displayLink = CADisplayLink(target: self, selector: #selector(step(displayLink:)))
        displayLink.isPaused = true
        displayLink.add(to: .main, forMode: .commonModes)
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(pan(sender:)))
        self.addGestureRecognizer(pan!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        displayLink.remove(from: .main, forMode: .commonModes)
    }
    
    fileprivate func start() {
        displayLink.isPaused = false
    }
    
    fileprivate func stop() {
        displayLink.isPaused = true
    }
    
    @objc func step(displayLink: CADisplayLink) {
        historyCount += 1
        if lastUpdateTimestamp <= 0 {
            lastUpdateTimestamp = displayLink.timestamp
        }
        
        let interval = displayLink.timestamp - lastUpdateTimestamp
        if interval >= 1 {
            lastUpdateTimestamp = displayLink.timestamp
            fps = Int(ceil(Double(historyCount) / interval))
            let text = "\(fps) FPS"
            historyCount = 0
            
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: text.count))
            if fps < 55 {
                attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: "\(fps)".count))
            }
            self.attributedText = attributedString
        }
    }
    
    @objc func pan(sender: UIPanGestureRecognizer) {
        guard let app = UIApplication.shared.delegate, let window = app.window else {
            return;
        }
        print(sender.location(in: window!))
        if sender.state == .began {
            alpha = 0.5
        } else if sender.state == .changed {
            self.center = sender.location(in: window!)
        } else if sender.state == .ended {
            let newFrame = CGRect(x: min(window!.frame.width - frame.width, max(0, frame.origin.x)),
                                  y: min(window!.frame.height - frame.height, max(0, frame.origin.y)),
                                  width: frame.width,
                                  height: frame.height)
            UIView.animate(withDuration: 0.2, animations: {
                self.frame = newFrame
                self.alpha = 1
            })
        }
    }
}


