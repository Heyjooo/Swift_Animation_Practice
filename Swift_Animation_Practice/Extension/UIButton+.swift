//
//  UIButton+.swift
//  Swift_Animation_Practice
//
//  Created by 변희주 on 2023/11/12.
//

import UIKit

extension UIButton {
    func shakeButton() {
        self.transform = CGAffineTransform(translationX: 0, y: 5)
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.005,
                       initialSpringVelocity: 1.0,
                       options: [.curveEaseInOut]) {
            self.transform = .identity
        }
    }
}
