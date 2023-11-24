//
//  ThirdStudyViewController.swift
//  Swift_Animation_Practice
//
//  Created by 변희주 on 2023/11/20.
//

import UIKit

import SnapKit

final class ThirdStudyViewController: UIViewController {

    private let startButton: UIButton = {
       let button = UIButton()
        button.setTitle("START", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private let countDownView = CountdownProgressBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setLayout()
    }
    
    private func setLayout() {
        view.addSubviews(startButton, countDownView)
        
        startButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(150)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(40)
        }
        
        countDownView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(180)
        }
    }
    
    @objc
    private func startButtonClicked() {
        // start 버튼을 누르면 count down 및 애니메이션 시작
        countDownView.startCountDown(duration: 10.0)
    }

}
