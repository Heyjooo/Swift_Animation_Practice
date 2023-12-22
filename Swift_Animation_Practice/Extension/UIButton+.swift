//
//  UIButton+.swift
//  Swift_Animation_Practice
//
//  Created by 변희주 on 2023/11/12.
//

import UIKit

extension UIButton {
    func shakeButton() {
        // 버튼을 흔들리게 하는 애니메이션
        let shakeAnimation = {
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.1,
                           initialSpringVelocity: 3.0,
                           options: [.curveEaseInOut]) {
                self.transform = .identity
            }
        }

        // 타이머를 이용해 반복적으로 애니메이션 실행
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
            self.transform = CGAffineTransform(translationX: 0, y: 5)
            shakeAnimation()
        }
    }
}
