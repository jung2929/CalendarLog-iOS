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
        // 윗 쪽 파랑배경 설정
        let backgroundTopimageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 272))
        if let backgroundTopImage = UIImage(named: "background_top.png") {
            backgroundTopimageView.image = backgroundTopImage
        }
        self.view.addSubview(backgroundTopimageView)
    }
}
