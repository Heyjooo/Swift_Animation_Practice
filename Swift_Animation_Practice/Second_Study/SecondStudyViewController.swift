//
//  SecondStudyViewController.swift
//  Swift_Animation_Practice
//
//  Created by 변희주 on 2023/11/13.
//

import UIKit

import SnapKit

final class SecondStudyViewController: UIViewController {
    
    let testView: UIView = {
        let view = UIView(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: UIScreen.main.bounds.height / 2 - 100, width: 200, height: 200))
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUI()
        target()
    }
    
    private func setUI() {
        view.addSubview(testView)
    }
    
    private func target() {
        //UITapGestureRecognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tapGesture.numberOfTapsRequired = 5
        testView.addGestureRecognizer(tapGesture)
        
        //UIPinchGestureRecognizer
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(viewPinched))
        testView.addGestureRecognizer(pinchGesture)
        
        //UIRotationGestureRecognizer
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(viewRotated))
        testView.addGestureRecognizer(rotationGesture)
        
        //UISwipeGestureRecognizer
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(viewSwiped))
        swipeRightGesture.direction = .right
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(viewSwiped))
        swipeRightGesture.direction = .left
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(viewSwiped))
        swipeUpGesture.direction = .up
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(viewSwiped))
        swipeDownGesture.direction = .down
        
        self.view.addGestureRecognizer(swipeRightGesture)
        self.view.addGestureRecognizer(swipeLeftGesture)
        self.view.addGestureRecognizer(swipeUpGesture)
        self.view.addGestureRecognizer(swipeDownGesture)

        //UILongPressGestureRecognizer
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(viewPressed))
        longPressGesture.minimumPressDuration = 5.0
        longPressGesture.numberOfTouchesRequired = 2
//        longPressGesture.allowableMovement = 10
        self.testView.addGestureRecognizer(longPressGesture)

        //UIPanGestureRecognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPanned))
        self.testView.addGestureRecognizer(panGesture)
    }
    
    @objc
    private func viewTapped(gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 1.0, animations: { [self] in
            testView.frame.origin.x += 50
        }, completion: { _ in
            UIView.animate(withDuration: 1.0, animations: { [self] in
                testView.frame.origin.x -= 50
            })
        })
    }
    
    @objc
    private func viewPinched(gesture: UIPinchGestureRecognizer) {
        guard let view = gesture.view else { return }
        view.transform = view.transform.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1
    }
    
    @objc
    private func viewRotated(gesture: UIRotationGestureRecognizer) {
        guard let view = gesture.view else { return }
        view.transform = view.transform.rotated(by: gesture.rotation)
        gesture.rotation = 0
    }
    
    @objc
    private func viewSwiped(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            self.view.backgroundColor = .systemPink
        } else if gesture.direction == .left {
            self.view.backgroundColor = .white
        } else if gesture.direction == .up {
            self.view.backgroundColor = .systemCyan
        } else {
            self.view.backgroundColor = .black
        }
    }
    
    @objc
    private func viewPressed(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            print("Start\n")
        case .changed:
            print("Change\n")
        case .ended:
            print("End\n")
        case .possible:
            print("Possibe")
        case .cancelled:
            print("Cancel")
        case .failed:
            print("Fail")
        @unknown default:
            print("어쩔")
        }
    }
    
    @objc
    private func viewPanned(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        if let viewToMove = gesture.view {
            viewToMove.center = CGPoint(x: viewToMove.center.x + translation.x, y: viewToMove.center.y + translation.y)
        }
        
        gesture.setTranslation(.zero, in: view)
    }
}
