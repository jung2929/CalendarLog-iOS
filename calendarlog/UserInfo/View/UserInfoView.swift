//
//  UserInfoView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class UserInfoView: SuperViewController {
    var presenter: UserInfoPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        // 내비게이션바 우측상단 설정 이미지 설정
        let settingBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_setting"), style: .done, target: self, action: #selector(self.pushSetting))
        // 내비게이션바 우측상단 수정 이미지 설정
        let editBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_edit"), style: .done, target: self, action: #selector(self.pushEdit))
        self.navigationItem.rightBarButtonItems = [settingBarButtonItem, editBarButtonItem]
    }
}

extension UserInfoView: UserInfoViewProtocol {
    @objc func pushEdit() {
        ()
    }
    
    @objc func pushSetting() {
        ()
    }
    
    func initializeUI() {
        // 윗 쪽 파랑배경 설정
        let backgroundTopimageView: UIImageView = UIImageView()
        if let backgroundTopImage = UIImage(named: "background_top") {
            backgroundTopimageView.image = backgroundTopImage
        }
        self.view.addSubview(backgroundTopimageView)
        backgroundTopimageView.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(self.view.frame.height / 2.5)
        }
    }
}
