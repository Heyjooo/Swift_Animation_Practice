//
//  FirstAssignmentViewController.swift
//  Swift_Animation_Practice
//
//  Created by 변희주 on 2023/11/12.
//

import UIKit

import SnapKit

final class FirstAssignmentViewController: UIViewController {
    
    private let shakeLabel: UILabel = {
        let label = UILabel()
        label.text = "아래 버튼을 눌러봐 !!!"
        label.textColor = .systemPink
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private let shakeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: UIScreen.main.bounds.height / 3 - 50, width: 200, height: 50))
        button.setTitle("Shake Button", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 15
        button.layer.backgroundColor = UIColor.systemPink.cgColor
        button.addTarget(self, action: #selector(didShakeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let toastLabel: UILabel = {
        let label = UILabel()
        label.text = "아래 버튼도 눌러봐 !!!"
        label.textColor = .systemPink
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private let toastButton: UIButton = {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: UIScreen.main.bounds.height / 2 - 50, width: 200, height: 50))
        button.setTitle("Toast Message Button", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 15
        button.layer.backgroundColor = UIColor.systemPink.cgColor
        button.addTarget(self, action: #selector(didToastButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let heartLabel: UILabel = {
        let label = UILabel()
        label.text = "마지막으로 이 버튼도 눌러봐 !!!"
        label.textColor = .systemPink
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private let heartImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "heart")
        return imageView
    }()
    
    private let extensionButton: UIButton = {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 100, y: UIScreen.main.bounds.height / 4 * 3 - 50, width: 200, height: 50))
        button.setTitle("Extension Button", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 15
        button.layer.backgroundColor = UIColor.systemPink.cgColor
        button.addTarget(self, action: #selector(didExtensionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubviews(shakeLabel,
                         shakeButton,
                         toastLabel,
                         toastButton,
                         heartLabel,
                         heartImage,
                         extensionButton)
        
        shakeLabel.snp.makeConstraints {
            $0.bottom.equalTo(shakeButton.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
        }
        
        toastLabel.snp.makeConstraints {
            $0.bottom.equalTo(toastButton.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
        }
        
        heartLabel.snp.makeConstraints {
            $0.top.equalTo(extensionButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        heartImage.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.bottom.equalTo(extensionButton.snp.top).offset(-40)
            $0.centerX.equalToSuperview()
        }
    }
    
    // 토스트메세지
    private func showToast() {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = .black
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.font = .systemFont(ofSize: 15)
        toastLabel.text = "메롱ㅋ메롱ㅋㅋ메롱ㅋㅋㅋ"
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 8
        toastLabel.clipsToBounds = true

        toastLabel.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 150,
                                  y: UIScreen.main.bounds.height - 100,
                                  width: 300,
                                  height: 40)
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(toastLabel)
        }
        
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    @objc
    private func didShakeButtonTapped() {
        shakeButton.shakeButton()
    }
    
    @objc
    private func didToastButtonTapped() {
        showToast()
    }
    
    @objc
    private func didExtensionButtonTapped() {
        UIView.animate(withDuration: 1.0) { [self] in
            // 크기를 3배로 확대
            heartImage.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        } completion: { _ in
            // 애니메이션이 끝난 후에 실행되는 코드
            UIView.animate(withDuration: 1.0) {
                // 다시 원래 크기로 돌아가기
                self.heartImage.transform = .identity
            }
        }
    }
}
