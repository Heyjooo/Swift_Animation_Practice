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
    var isTopReach: Bool = false
    var isBottomReach: Bool = false
    var isLeadingReach: Bool = false
    var isTrailingReach: Bool = false
    
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
        label.font = .systemFont(ofSize: 20)
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
        scoreLabel.text = "훈이를 피해라 !!!"
        self.timer = Timer.scheduledTimer(timeInterval: 0.1,
                                          target: self,
                                          selector: #selector(self.moveHuni),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        score = 0
        // 타이머 끝나면 원래 이미지로 돌려놓기
        leadingHuni.image =  UIImage(named: "huni")?.imageFlippedHorizontally()
        trailingHuni.image = UIImage(named: "huni")
    }
    
    private func setLayout() {
        self.view.addSubviews(jjangGu,
                              scoreLabel,
                              topHuni,
                              bottomHuni,
                              leadingHuni,
                              trailingHuni)
        
        // 글씨에 가려지지 않게 짱구와 훈이를 view의 맨 앞으로
        self.view.bringSubviewToFront(jjangGu)
        self.view.bringSubviewToFront(topHuni)
        self.view.bringSubviewToFront(bottomHuni)

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
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(70)
        }
    }
    
    //startTimer가 시작되면 실행되는 함수(훈이가 움직이는 함수)
    @objc
    private func moveHuni() {
        var topHuniY = self.topHuni.frame.origin.y
        // topHuni가 벽에 닿았는지 안닿았는지 확인
        if topHuniY > UIScreen.main.bounds.height - 50 {
            isTopReach = true
        }
        if topHuniY < 50 {
            isTopReach = false
        }
        
        // 벽에 닿았는지 안닿았는지에 따라 위치 조정
        if isTopReach {
            topHuniY -= 10
            topHuni.image = topHuni.image?.imageFlippedHorizontally()
        } else {
            topHuniY += 10
            topHuni.image = topHuni.image?.imageFlippedHorizontally()
        }
        
        self.topHuni.frame = .init(origin: .init(x: self.topHuni.frame.origin.x,
                                                  y: topHuniY),
                                    size: self.topHuni.frame.size)
        
        var bottomHuniY = self.bottomHuni.frame.origin.y
        // bottomHuni가 벽에 닿았는지 안닿았는지 확인
        if bottomHuniY < 50 {
            isBottomReach = true
        }
        if bottomHuniY > UIScreen.main.bounds.height - 50 {
            isBottomReach = false
        }
        
        // 벽에 닿았는지 안닿았는지에 따라 위치 조정
        if isBottomReach {
            bottomHuniY += 10
            bottomHuni.image = bottomHuni.image?.imageFlippedHorizontally()
        } else {
            bottomHuniY -= 10
            bottomHuni.image = bottomHuni.image?.imageFlippedHorizontally()
        }
        
        self.bottomHuni.frame = .init(origin: .init(x: self.bottomHuni.frame.origin.x, y: bottomHuniY),
                                       size: self.bottomHuni.frame.size)
        
        var leftHuniX = self.leadingHuni.frame.origin.x
        // leadingHuni가 벽에 닿았는지 안닿았는지 확인
        if leftHuniX > UIScreen.main.bounds.width - 50 {
            isLeadingReach = true
        }
        if leftHuniX < 0 {
            isLeadingReach = false
        }
        
        // 벽에 닿았는지 안닿았는지에 따라 위치 조정
        if isLeadingReach {
            leftHuniX -= 10
            leadingHuni.image = leadingHuni.image?.imageFlippedHorizontally()
        } else {
            leftHuniX += 10
            leadingHuni.image = leadingHuni.image?.imageFlippedHorizontally()
        }
        
        self.leadingHuni.frame = .init(origin: .init(x: leftHuniX, y: self.leadingHuni.frame.origin.y),
                                        size: self.leadingHuni.frame.size)
        
        var rightHuniX = self.trailingHuni.frame.origin.x
        // trailingHuni가 벽에 닿았는지 안닿았는지 확인
        if rightHuniX < 0 {
            isTrailingReach = true
        }
        if rightHuniX > UIScreen.main.bounds.width - 50 {
            isTrailingReach = false
        }
        
        // 벽에 닿았는지 안닿았는지에 따라 위치 조정
        if isTrailingReach {
            rightHuniX += 10
            trailingHuni.image = trailingHuni.image?.imageFlippedHorizontally()
        } else {
            rightHuniX -= 10
            trailingHuni.image = trailingHuni.image?.imageFlippedHorizontally()
        }
        
        self.trailingHuni.frame = .init(origin: .init(x: rightHuniX,
                                                       y: self.trailingHuni.frame.origin.y),
                                         size: self.trailingHuni.frame.size)
        // 거리 계산
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
        // Press gesture 제거
        if let pressGesture = jjangGuPressGesture {
            jjangGu.removeGestureRecognizer(pressGesture)
            jjangGuPressGesture = nil
        }
        
        // Pan gesture 제거
        if let panGesture = jjangGuPanGesture {
            jjangGu.removeGestureRecognizer(panGesture)
            jjangGuPanGesture = nil
        }
        
    
        scoreLabel.text = "잡혀버렸어..\nScore : \(score)점"
        stopTimer()
        
        // Gesture 다시 추가
        addTarget()
        isPause = true
    }

}

extension SecondAssignmentViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
