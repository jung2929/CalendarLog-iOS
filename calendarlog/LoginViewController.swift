//
//  ViewController.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 4. 4..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: SuperViewController {
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "logo.png")
        imageView.image = image
        return imageView
    }()
    let titleImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "title.png")
        imageView.image = image
        return imageView
    }()
    // 로그인 뷰 설정
    let centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 19
        return view
    }()
    // 로그인 뷰 라벨 설정
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = ColorPalette.Primary
        return label
    }()
    // 로그인 뷰 이메일 텍스트 필드 설정
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return textField
    }()
    // 로그인 뷰 이메일 텍스트 필드 하단 라인 설정
    let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 로그인 뷰 로그인 혹은 회원가입 버튼 설정
    let loginOrRegisterButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        button.backgroundColor = ColorPalette.BlueForButton
        button.layer.cornerRadius = 26
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUI()
        self.emailTextField.delegate = self
        self.loginOrRegisterButton.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
    }
    func initializeUI() {
        // 로고 이미지 추가
        self.view.addSubview(self.logoImageView)
        self.logoImageView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.top.equalTo(44)
        }
        // 로고 타이틀 추가
        self.view.addSubview(self.titleImageView)
        self.titleImageView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.top.equalTo(63 + 44 + 6)
        }
        // 로그인 라벨 추가
        self.centerView.addSubview(self.loginLabel)
        self.loginLabel.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.top.equalTo(20)
        }
        // 이메일 텍스트 필드 추가
        self.centerView.addSubview(self.emailTextField)
        self.emailTextField.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.top.equalTo(100)
            view.left.equalTo(20)
            view.right.equalTo(-20)
        }
        // 이메일 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.bottomBorderView)
        self.bottomBorderView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.height.equalTo(1)
            view.top.equalTo(128.5)
            view.left.equalTo(20)
            view.right.equalTo(-20)
        }
        // 로그인 혹은 회원가입 버튼 추가
        self.centerView.addSubview(self.loginOrRegisterButton)
        self.loginOrRegisterButton.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.size.height.equalTo(50)
            view.bottom.equalTo(-29)
            view.left.equalTo(20)
            view.right.equalTo(-20)
        }
        // 로그인 뷰 추가
        self.view.addSubview(self.centerView)
        self.centerView.snp.makeConstraints { view in
            view.center.equalToSuperview()
            view.size.width.equalTo(343)
            view.size.height.equalTo(252)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    // 로그인 혹은 회원가입 버튼 눌렀을 경우 함수
    @objc func buttonPressed() {
        let alertViewController = UIAlertController(title: "이동", message: "어디로 갈래?", preferredStyle: .alert)
        let actionLogin = UIAlertAction(title: "로그인으로", style: .default, handler: { _ in
            //Todo. 로그인 페이지(비밀번호 포함)로 이동
        })
        let actionRegister = UIAlertAction(title: "회원가입으로", style: .default, handler: { _ in
            //Todo. 회원가입페이지로 이동
        })
        alertViewController.addAction(actionRegister)
        alertViewController.addAction(actionLogin)
        self.present(alertViewController, animated: true, completion: nil)
    }
    // 텍스트 필드 선택했을 경우 밑줄 색상 변경
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            self.bottomBorderView.backgroundColor = ColorPalette.Primary
        default:
            ()
        }
        return
    }
    // 텍스트 필드 빠져나갔을 경우 밑줄 색상 변경
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            self.bottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        default:
            ()
        }
    }
}
