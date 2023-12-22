//
//  AnimationViewController.swift
//  Swift_Animation_Practice
//
//  Created by 변희주 on 2023/12/22.
//

import UIKit
import SnapKit

final class AnimationViewController: UIViewController {
    
    var timer: Timer?
    var progressViews: [UIProgressView] = []
    var currentIndex: Int = 0
    private let mainStrings: [String] = [Strings.mainString.first, Strings.mainString.second, Strings.mainString.third, Strings.mainString.fourth]
    private let subStrings: [String] = [Strings.subString.first, Strings.subString.second, Strings.subString.third, Strings.subString.fourth]
    
    private let progressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.shakeButton()
        return button
    }()
    
    private let mainString: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 28)
        label.numberOfLines = 2
        return label
    }()
    
    private let subString: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setLayout()
        setTimer()
    }
    
    private func setStyle() {
        self.view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews(progressStackView,
                         mainString,
                         subString,
                         nextButton)
        
        for _ in 0..<4 {
            let progressView = UIProgressView()
            progressView.trackTintColor = .systemGray6
            progressView.progressTintColor = .systemBlue
            progressViews.append(progressView)
            progressStackView.addArrangedSubview(progressView)
        }
        
        progressStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 20)
            $0.height.equalTo(3)
        }
        
        mainString.snp.makeConstraints {
            $0.top.equalTo(progressStackView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(20)
        }
        
        subString.snp.makeConstraints {
            $0.top.equalTo(mainString.snp.bottom).offset(10)
            $0.leading.equalTo(mainString)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(70)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(55)
        }
    }
    
    private func setTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(setProgress), userInfo: nil, repeats: true)
    }
    
    private func fadeInTextAnimation() {
        UIView.animate(withDuration: 1.0) {
            self.mainString.alpha = 1.0
            self.subString.alpha = 1.0
        }
    }
    
    @objc
    private func setProgress() {
        let duration: Float = 3.0
        let timeInterval: Float = 0.0001
        let steps = Int(duration / timeInterval)
        
        progressViews[currentIndex].setProgress(Float(progressViews[currentIndex].progress) + timeInterval / duration, animated: true)
        
        mainString.text = mainStrings[currentIndex]
        subString.text = subStrings[currentIndex]

        if Int(progressViews[currentIndex].progress * Float(steps)) >= steps {
            progressViews[currentIndex].setProgress(1.0, animated: true)
            currentIndex += 1
            if currentIndex < progressViews.count {
                progressViews[currentIndex].setProgress(0.0, animated: false)
                mainString.text = mainStrings[currentIndex]
                subString.text = subStrings[currentIndex]
                mainString.alpha = 0.0
                subString.alpha = 0.0
                fadeInTextAnimation()
            } else {
                currentIndex = 0
                for progressView in progressViews {
                    progressView.setProgress(0.0, animated: false)
                }
                setTimer()
                mainString.alpha = 0.0
                subString.alpha = 0.0
                fadeInTextAnimation()
            }
        }
    }
}
