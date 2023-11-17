//
//  SecondStudyAssignmentViewController.swift
//  Swift_Animation_Practice
//
//  Created by 변희주 on 2023/11/17.
//

import UIKit

import SnapKit

final class SecondAssignmentViewController: UIViewController {
    var score: Int = 0
    var timer: Timer? = nil
    var isPause: Bool = true
    var jjangGuPanGesture: UIPanGestureRecognizer?
    var jjangGuPressGesture: UILongPressGestureRecognizer?

    
    private lazy var jjangGu = UIImageView(image: UIImage(named: "jjangGu"))
    
    private let topHuni = UIImageView(image: UIImage(named: "huni")?.imageFlippedHorizontally())
    private let bottomHuni = UIImageView(image: UIImage(named: "huni"))
    private let leadingHuni = UIImageView(image: UIImage(named: "huni")?.imageFlippedHorizontally())
    private let trailingHuni = UIImageView(image: UIImage(named: "huni"))
    
    private var scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "훈이를 피해라 !!!"
        label.font = UIFont(name: "Korail-Round-Gothic-Light", size: 25)
        label.textColor = .systemCyan
        label.numberOfLines = 2
        return label
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        setLayout()
        addTarget()
    }
    
    private func addTarget() {
        //Press Gesture 추가
        let pressGesture = UILongPressGestureRecognizer(target: self, action: #selector(viewPressed))
        pressGesture.minimumPressDuration = 0 // 0초로 설정
        pressGesture.delegate = self // Pan Gesture와의 충돌방지
        jjangGu.addGestureRecognizer(pressGesture)
        jjangGuPressGesture = pressGesture
        
        //Pan Gesture 추가
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPanned))
        jjangGu.addGestureRecognizer(panGesture)
        jjangGu.isUserInteractionEnabled = true
        panGesture.delegate = self // Press Gesture와의 충돌방지
        jjangGuPanGesture = panGesture
    }
    
    //Press 제스처 함수
    @objc
    private func viewPressed(gesture : UILongPressGestureRecognizer) {
        if isPause {
            isPause = false
            scoreLabel.text = "게임시작 !!!"
            startTimer()
        }
    }
    
    //Pan 제스처 함수
    @objc
    private func viewPanned(_ sender: UIPanGestureRecognizer) {
        let transition = sender.translation(in: jjangGu)
        let changedX = jjangGu.center.x + transition.x
        let changedY = jjangGu.center.y + transition.y
        
        self.jjangGu.center = .init(x: changedX,
                                    y: changedY)
        sender.setTranslation(.zero, in: self.jjangGu)
    }

    
    // 시간 측정
    private func startTimer() {
        guard timer == nil else { return }
        self.timer = Timer.scheduledTimer(timeInterval: 0.3,
                                          target: self,
                                          selector: #selector(self.moveHuni),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func setLayout() {
        self.view.addSubviews(jjangGu,
                              scoreLabel,
                              topHuni,
                              bottomHuni,
                              leadingHuni,
                              trailingHuni)
        
        jjangGu.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(90)
        }
        
        topHuni.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        leadingHuni.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview().inset(3)
            $0.size.equalTo(50)
        }
        
        trailingHuni.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview().inset(3)
            $0.size.equalTo(50)
        }
        
        bottomHuni.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        scoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(50)
        }
    }
    
    //startTimer가 시작되면 실행되는 함수(훈이가 움직이는 함수)
    @objc
    private func moveHuni() {
        var topHuniY = self.topHuni.frame.origin.y
        topHuniY += 10
        self.topHuni.frame = .init(origin: .init(x: self.topHuni.frame.origin.x,
                                                  y: topHuniY),
                                    size: self.topHuni.frame.size)
        
        var bottomHuniY = self.bottomHuni.frame.origin.y
        bottomHuniY -= 10
        self.bottomHuni.frame = .init(origin: .init(x: self.bottomHuni.frame.origin.x, y: bottomHuniY),
                                       size: self.bottomHuni.frame.size)
        
        var leftHuniX = self.leadingHuni.frame.origin.x
        leftHuniX += 10
        self.leadingHuni.frame = .init(origin: .init(x: leftHuniX, y: self.leadingHuni.frame.origin.y),
                                        size: self.leadingHuni.frame.size)
        
        var rightHuniX = self.trailingHuni.frame.origin.x
        rightHuniX -= 10
        self.trailingHuni.frame = .init(origin: .init(x: rightHuniX,
                                                       y: self.trailingHuni.frame.origin.y),
                                         size: self.trailingHuni.frame.size)
        self.calculatePositionReached()
    }
    
    private func calculatePositionReached() {
        let collisionDistance: CGFloat = 50.0 // 충돌로 판정할 거리
        
        // topHuni와의 충돌 감지
        let distanceToTopHuni = calculateDistanceBetweenViews(jjangGu, topHuni)
        if distanceToTopHuni <= collisionDistance {
            endGame()
            return
        }

        // leadingHuni와의 충돌 감지
        let distanceToLeadingHuni = calculateDistanceBetweenViews(jjangGu, leadingHuni)
        if distanceToLeadingHuni <= collisionDistance {
            endGame()
            return
        }

        // trailingHuni와의 충돌 감지
        let distanceToTrailingHuni = calculateDistanceBetweenViews(jjangGu, trailingHuni)
        if distanceToTrailingHuni <= collisionDistance {
            endGame()
            return
        }

        // bottomHuni와의 충돌 감지
        let distanceToBottomHuni = calculateDistanceBetweenViews(jjangGu, bottomHuni)
        if distanceToBottomHuni <= collisionDistance {
            endGame()
            return
        }

        // 충돌이 없을 경우
        score += 10
    }

    // 두 뷰 간의 거리를 측정하는 함수
    private func calculateDistanceBetweenViews(_ view1: UIView, _ view2: UIView) -> CGFloat {
        let center1 = view1.center
        let center2 = view2.center
        let dx = center1.x - center2.x
        let dy = center1.y - center2.y
        return sqrt(dx*dx + dy*dy)
    }
    
    // 게임 종료 함수
    private func endGame() {
        // Pan gesture 제거
        if let panGesture = jjangGuPanGesture {
            jjangGu.removeGestureRecognizer(panGesture)
            jjangGuPanGesture = nil
        }
        
        // Press gesture 제거
        if let pressGesture = jjangGuPressGesture {
            jjangGu.removeGestureRecognizer(pressGesture)
            jjangGuPressGesture = nil
        }
        
        scoreLabel.text = "끝났어..\nScore : \(score)점"
        stopTimer()
        
        // PanGesture 다시 추가
        addTarget()
        isPause = true
    }

}

extension SecondAssignmentViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
