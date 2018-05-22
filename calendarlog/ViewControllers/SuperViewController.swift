//
//  SuperViewController.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 8..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class SuperViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // 영역 밖 클릭시 키보드 숨기기
        self.hideKeyboardWhenTappedAround()
        // 배경색상 설정
        self.view.backgroundColor = ColorPalette.Background
        // 내비게이션바 배경 투명 설정
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        // 내비게이션바 테두리 지우기
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // MARK: NavigationBar 좌측상단 뒤로가기 이미지 설정
        let imageBack = UIImage(named: "ic_back.png")
        self.navigationController?.navigationBar.backIndicatorImage = imageBack
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imageBack
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .white
        // MARK: Navigation backbarbuttonitem 에 title 을 없애주기 위한 작업
        self.title = ""
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        // 윗 쪽 파랑배경 설정
        let backgroundTopimageView: UIImageView = UIImageView()
        if let backgroundTopImage = UIImage(named: "background_top.png") {
            backgroundTopimageView.image = backgroundTopImage
        }
        self.view.addSubview(backgroundTopimageView)
        backgroundTopimageView.snp.makeConstraints { view in
            view.left.equalTo(0)
            view.right.equalTo(0)
            view.height.equalTo(self.view.frame.height / 2.5)
        }
    }
}
