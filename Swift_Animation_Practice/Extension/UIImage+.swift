//
//  UIImage+.swift
//  Swift_Animation_Practice
//
//  Created by 변희주 on 2023/11/17.
//

import UIKit

extension UIImage {
    func imageFlippedHorizontally() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()!

        context.translateBy(x: size.width, y: 0)
        context.scaleBy(x: -1.0, y: 1.0)

        draw(in: CGRect(origin: .zero, size: size))

        let flippedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return flippedImage
    }
}
