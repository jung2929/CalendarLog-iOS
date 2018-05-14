//
//  RegisterViewController.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 13..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class RegisterViewController: SuperViewController {
    var emailValue = ""
    // 회원가입 뷰 설정
    let centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 19
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUI()
    }
    func initializeUI() {
        // 회원가입 뷰 추가
        self.view.addSubview(self.centerView)
        self.centerView.snp.makeConstraints { view in
//            view.size.width.equalTo(343)
            view.right.equalTo(self.view).offset(-20)
            view.left.equalTo(self.view).offset(20)
            view.bottom.equalTo(self.view).offset(-20)
            view.top.equalTo(self.view).offset(64)
//            view.edges.trailing.equalTo(16)
//            view.edges.leading.equalTo(16)
//            view.edges.top.equalTo(64)
//            view.edges.bottom.equalTo(29)
//            view.size.height.equalTo(300)
        }
    }
}
