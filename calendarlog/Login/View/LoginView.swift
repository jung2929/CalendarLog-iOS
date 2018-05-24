//
//  LoginView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 24..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class LoginView: SuperViewController {
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    
    // 로그인 뷰 설정
    let centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 19
        return view
    }()
    // 이메일 텍스트 필드 설정
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.textContentType = UITextContentType.emailAddress
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        return textField
    }()
    // 이메일 텍스트 필드 하단 라인 설정
    let emailBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 비밀번호 텍스트 필드 설정
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.textContentType = UITextContentType.password
        textField.isSecureTextEntry = true
        return textField
    }()
    // 비밀번호 텍스트 필드 하단 라인 설정
    let passwordBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 오류 텍스트 필드 설정
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.textColor = ColorPalette.RedForText
        return label
    }()
    // 로그인 혹은 회원가입 버튼 설정
    let loginOrRegisterButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인 혹은 회원가입", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        button.backgroundColor = ColorPalette.BlueForButton
        button.layer.cornerRadius = 26
        return button
    }()
}

extension LoginView: LoginViewProtocol {
    func showError() {
        //
    }
    
    func showLoading() {
        //
    }
    
    func hideLoading() {
        //
    }
    
    func initializeUI() {
        // 로고 설정
        let logoImageView: UIImageView = UIImageView(image: UIImage(named: "logo_login.png"))
        // 타이틀 설정
        let titleImageView: UIImageView = UIImageView(image: UIImage(named: "title_login.png"))
        // 로그인 뷰 라벨 설정
        let loginLabel: UILabel = UILabel()
        loginLabel.text = "Login"
        loginLabel.textColor = ColorPalette.Primary
        // 로고 이미지 추가
        self.view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view).offset(40)
        }
        // 로고 타이틀 추가
        self.view.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom)
        }
        // 로그인 라벨 추가
        self.centerView.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        // 상, 좌, 우 간격
        let offsetLeftValue = 20
        let offsetRightValue = -20
        // 이메일 텍스트 필드 추가
        self.centerView.addSubview(self.emailTextField)
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 이메일 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.emailBottomBorderView)
        self.emailBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.emailTextField.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.size.height.equalTo(1)
        }
        // 로그인 혹은 회원가입 버튼 추가
        self.centerView.addSubview(self.loginOrRegisterButton)
        self.loginOrRegisterButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.bottom.equalTo(self.centerView.snp.bottom).offset(-25)
            make.size.height.equalTo(50)
        }
        // 오류 라벨 추가
        self.centerView.addSubview(self.errorLabel)
        self.errorLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.bottom.equalTo(self.loginOrRegisterButton.snp.top).offset(-20)
        }
        // 로그인 뷰 추가
        self.view.addSubview(self.centerView)
        self.centerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.size.height.equalTo(252)
        }
    }
}
