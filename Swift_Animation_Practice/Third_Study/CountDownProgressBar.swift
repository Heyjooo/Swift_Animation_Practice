//
//  CountDownProgressBar.swift
//  Swift_Animation_Practice
//
//  Created by 변희주 on 2023/11/24.
//

import UIKit

class CountdownProgressBar: UIView {
    private var timer = Timer()
    private var remainingTime = 0.0
    
    private lazy var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 13
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.frame = bounds
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    
    private lazy var foregroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 13
        layer.strokeColor = UIColor.systemPink.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        layer.frame = bounds
        return layer
    }()
    
    private lazy var pulseLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 13
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.frame = bounds
        return layer
    }()
    
    private lazy var remainingTimeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: bounds.width,
                                          height: bounds.height))
        label.text = "10초"
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textAlignment = .center
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        let centerPoint = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let circularPath = UIBezierPath(arcCenter: centerPoint,
                                        radius: bounds.width / 2,
                                        startAngle: -CGFloat.pi / 2,
                                        endAngle: 2 * CGFloat.pi - CGFloat.pi / 2,
                                        clockwise: true)
        
        pulseLayer.path = circularPath.cgPath
        layer.addSublayer(pulseLayer)
        
        backgroundLayer.path = circularPath.cgPath
        layer.addSublayer(backgroundLayer)
        
        foregroundLayer.path = circularPath.cgPath
        
        addSubview(remainingTimeLabel)
    }
    
    private func animateForegroundLayer(duration: Double) {
        let foregroundAnimation = CABasicAnimation(keyPath: "strokeEnd")
        foregroundAnimation.fromValue = 0
        foregroundAnimation.toValue = 1
        foregroundAnimation.duration = duration
        foregroundAnimation.isRemovedOnCompletion = false
        
        foregroundLayer.add(foregroundAnimation, forKey: "foregroundAnimation")
    }
    
    private func animatePulseLayer() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 1.2
        
        let pulseOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        pulseOpacityAnimation.fromValue = 0.8
        pulseOpacityAnimation.toValue = 0.0
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [pulseAnimation, pulseOpacityAnimation]
        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animationGroup.duration = 1.0
        animationGroup.repeatCount = Float.infinity
        
        pulseLayer.add(animationGroup, forKey: "pulseAnimation")
    }
    
    // 카운트 다운을 시작하기 위한 초기 작업
    func startCountDown(duration: Double) {
        remainingTime = duration
        remainingTimeLabel.text = "\(remainingTime)"
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(handleTimerTick),
                                     userInfo: nil,
                                     repeats: true)
        
        handleTimerTick()
        layer.addSublayer(foregroundLayer)
        animatePulseLayer()
        animateForegroundLayer(duration: duration)
    }
    
    // 1초마다 남은 시간을 확인해서 남은 시간 업데이트
    @objc
    func handleTimerTick() {
        remainingTime -= 1
        
        if remainingTime < 0 {
            remainingTime = 0
            pulseLayer.removeAllAnimations()
            foregroundLayer.removeFromSuperlayer()
            timer.invalidate()
        }
        
        remainingTimeLabel.text = "\(Int(self.remainingTime))초 !!!"
        if remainingTime == 0 {
            remainingTimeLabel.text = "끝 !!!"
        }
        
    }
}
