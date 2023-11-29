//
//  dd.swift
//  Swift_Animation_Practice
//
//  Created by 변희주 on 2023/11/29.
//

import UIKit

class Transform3DViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewToTransform = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        viewToTransform.backgroundColor = .systemPink
        self.view.addSubview(viewToTransform)
        
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 500
        transform = CATransform3DRotate(transform, CGFloat(45 * Double.pi / 180), 0, 1, 0) // x, y, z 방향으로 돈다.
        viewToTransform.layer.transform = transform
    }
}
