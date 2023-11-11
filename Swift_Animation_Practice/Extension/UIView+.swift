//
//  UIView+.swift
//  Swift_Animation_Practice
//
//  Created by 변희주 on 2023/11/12.
//

import UIKit
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
