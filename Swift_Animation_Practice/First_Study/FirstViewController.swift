//
//  ViewController.swift
//  Swift_Animation_Practice
//
//  Created by 변희주 on 2023/11/11.
//

import UIKit

final class FirstViewController: UIViewController {
    
    let testView : UIView = {
        let view = UIView(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: UIScreen.main.bounds.height / 4, width: 200, height: 200))
        view.backgroundColor = .systemPink
        return view
    }()
    
    let testButton : UIButton = {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: UIScreen.main.bounds.height / 3 * 2 - 50, width: 200, height: 50))
        button.setTitle("눌러봥!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.textColor = .white
        button.layer.backgroundColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(didMoveTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(testView)
        view.addSubview(testButton)
    }
    
    // CGAffineTransform
    private func transformMove() {
        UIView.animate(withDuration: 2.0) { [self] in
            testView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }
        
        UIView.animate(withDuration: 2.0) { [self] in
            testView.transform = CGAffineTransform(rotationAngle: .pi)
        }
        
        UIView.animate(withDuration: 2.0) { [self] in
            testView.transform = CGAffineTransform(translationX: 200, y: 200)
        }
    }
    
    // concatenating
    private func transformUnionMove() {
        UIView.animate(withDuration: 2.0) { [self] in
            let scale =  CGAffineTransform(scaleX: 2.0, y: 2.0)
            let rotate = CGAffineTransform(rotationAngle: .pi)
            let translation = CGAffineTransform(translationX: 200, y: 200)
            
            let concatenate = scale.concatenating(rotate).concatenating(translation)
            testView.transform = concatenate
        }
    }
    
    // completion
    private func transformSequentialMove() {
        UIView.animate(withDuration: 2.0) { [self] in
            testView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        } completion: { _ in
            UIView.animate(withDuration: 2.0) { [self] in
                testView.transform = CGAffineTransform(rotationAngle: .pi)
            } completion: { _ in
                UIView.animate(withDuration: 2.0) { [self] in
                    testView.transform = CGAffineTransform(translationX: 200, y: 200)
                }
            }
        }
    }
    
    // animateKeyFrames
    private func easyTransformSequentialMove() {
        UIView.animateKeyframes(withDuration: 3.0, delay: 0)  {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3) { [self] in
                testView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            }
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) { [self] in
                testView.transform = CGAffineTransform(rotationAngle: .pi)
            }
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) { [self] in
                testView.transform = CGAffineTransform(translationX: 200, y: 200)
            }
        }
    }
    
    // transition
    private func transitionMove() {
        UIView.transition(with: testView, duration: 0.6, options: .transitionFlipFromLeft, animations: nil)
        UIView.transition(with: testView, duration: 0.6, options: .transitionFlipFromRight, animations: nil)
        UIView.transition(with: testView, duration: 0.6, options: .transitionFlipFromTop, animations: nil)
        UIView.transition(with: testView, duration: 0.6, options: .transitionFlipFromBottom, animations: nil)
        UIView.transition(with: testView, duration: 0.6, options: .transitionCurlUp, animations: nil)
        UIView.transition(with: testView, duration: 0.6, options: .transitionCurlDown, animations: nil)
    }
    
    // modifyAnimation
    private func modifyMove() {
        UIView.animate(withDuration: 1.0) { [self] in
            UIView.modifyAnimations(withRepeatCount: 3.0, autoreverses: true) {
                testView.frame.origin.x += 100
            }
        }
    }
    
    // usingSpringWithDamping
    private func springDurationMove() {
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.testView.center.y += 100
        }, completion: nil)
    }
    
    
    @objc
    private func didMoveTap() {
        transitionMove()
        testButton.shakeButton()
    }
}

