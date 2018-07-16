//
//  SuperViewController.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 8..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit
import SnapKit

class SuperViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // 영역 밖 클릭시 키보드 숨기기
        self.hideKeyboardWhenTappedAround()
        // 배경색상 설정
        self.view.backgroundColor = ColorPalette.Background
        // 내비게이션바 배경 Primary 색상 설정
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "background_top.png"), for: .default)
        // 내비게이션바 테두리 지우기
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // 내비게이션바 아이콘 Tint 색상 설정
        self.navigationController?.navigationBar.tintColor = .white
        // Navigation backbarbuttonitem 에 title 을 없애주기 위한 작업
        self.title = ""
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        // 뒤로가기 커스텀 아이콘 적용
        let imageBack = UIImage(named: "ic_back.png")
        self.navigationController?.navigationBar.backIndicatorImage = imageBack
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imageBack
//        Primary 색상으로 배경을 주려고했는데, 연위에 setBackgroundImage 를 통해 전체 내비게이션바 색상 통일로 주석 처리
//        self.navigationController?.navigationBar.barTintColor = .white
//        밑에를 수행하지 않아도 잘 나오는 것 확인하여 주석 처리
//        self.navigationController?.navigationBar.isTranslucent = true
    }
}
