//
//  FirstAssignmentViewController.swift
//  Swift_Animation_Practice
//
//  Created by 변희주 on 2023/11/12.
//

import UIKit

import SnapKit

final class FirstAssignmentViewController: UIViewController {
    
    let shakeLabel: UILabel = {
        let label = UILabel()
        label.text = "아래 버튼을 눌러봐 !!!"
        label.textColor = .systemPink
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    let shakeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: UIScreen.main.bounds.height / 3, width: 200, height: 50))
        button.setTitle("Shake Button", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 17
        button.layer.backgroundColor = UIColor.systemPink.cgColor
        button.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubviews(shakeLabel, shakeButton)
        
        shakeLabel.snp.makeConstraints {
            $0.bottom.equalTo(shakeButton.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc
    private func didButtonTapped() {
        shakeButton.shakeButton()
    }
}
