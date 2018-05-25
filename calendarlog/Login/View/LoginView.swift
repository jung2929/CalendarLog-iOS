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
    // 상, 좌, 우 간격
    let offsetLeftValue = 20
    let offsetRightValue = -20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
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
        button.addTarget(self, action: #selector(pressedLoginOrRegisterButton), for: .touchUpInside)
        return button
    }()
}

extension LoginView: UITextFieldDelegate {
    // 텍스트 필드 수정할때 길이 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if textField == self.emailTextField && newString.length > 30 {
            self.showErrorForEmail(with: "이메일은 30자리까지 입력해주세요.")
            return false
        }
        if textField == self.passwordTextField && newString.length > 15 {
            self.showErrorForPassword(with: "비밀번호는 15자리까지 입력해주세요.")
            return false
        }
        return true
    }
    // Return Key 눌렀을시 메소드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.pressedLoginOrRegisterButton()
        // Return Key 버튼으로 다음줄로 가는것 true, false 값 (여기선 다음 텍스트필드로 이동하므로 값이 상관없음)
        return false
    }
    // 텍스트 필드 선택했을 경우 밑줄 색상 변경
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            self.emailBottomBorderView.backgroundColor = ColorPalette.Primary
        case self.passwordTextField:
            self.passwordBottomBorderView.backgroundColor = ColorPalette.Primary
        default:
            ()
        }
        return
    }
    // 텍스트 필드 빠져나갔을 경우 밑줄 색상 변경
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            self.emailBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        case self.passwordTextField:
            self.passwordBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        default:
            ()
        }
    }
}

extension LoginView: LoginViewProtocol {
    @objc func pressedLoginOrRegisterButton() {
        // 오류 문구 초기화
        self.errorLabel.text = ""
        self.emailBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        self.passwordBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        guard let email = self.emailTextField.text else {
            self.showErrorForEmail(with: "이메일을 입력해주세요.")
            return
        }
        guard email.count > 0 else {
            self.showErrorForEmail(with: "이메일을 입력해주세요.")
            return
        }
        self.presenter?.pressedLoginOrRegisterButton(email)
    }
    
    func addSubviewPassword() {
        UIView.animate(withDuration: 1.0) {
            // 이메일 텍스트 필드 이동
            self.emailTextField.isUserInteractionEnabled = false
            self.emailTextField.transform = CGAffineTransform(translationX: 0, y: -25)
            self.emailBottomBorderView.transform = CGAffineTransform(translationX: 0, y: -25)
            // 비밀번호 텍스트 필드 추가
            self.centerView.addSubview(self.passwordTextField)
            self.passwordTextField.snp.makeConstraints { make in
                make.top.equalTo(self.loginLabel.snp.bottom).offset(70)
                //make.top.equalTo(100)
                make.left.equalToSuperview().offset(self.offsetLeftValue)
                make.right.equalToSuperview().offset(self.offsetRightValue)
            }
            self.passwordTextField.layoutIfNeeded()
            // 비밀번호 텍스트 필드 하단 라인 추가
            self.centerView.addSubview(self.passwordBottomBorderView)
            self.passwordBottomBorderView.snp.makeConstraints { make in
                make.top.equalTo(self.passwordTextField.snp.bottom).offset(4)
                make.left.equalToSuperview().offset(self.offsetLeftValue)
                make.right.equalToSuperview().offset(self.offsetRightValue)
                make.size.height.equalTo(1)
            }
            self.passwordBottomBorderView.layoutIfNeeded()
        }
        self.loginOrRegisterButton.setTitle("로그인", for: .normal)
        self.loginOrRegisterButton.addTarget(self, action: #selector(pressedLoginButton), for: .touchUpInside)
    }
    
    func moveToRegister() {
        let registerViewController = RegisterViewController()
        registerViewController.emailValue = self.emailTextField.text!
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @objc func pressedLoginButton() {
        // 오류 문구 초기화
        self.errorLabel.text = ""
        self.emailBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        self.passwordBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        
        guard let password = self.passwordTextField.text else {
            self.showErrorForPassword(with: "비밀번호를 입력해주세요.")
            return
        }
        guard password.count > 0 else {
            self.showErrorForPassword(with: "비밀번호를 입력해주세요.")
            return
        }
        
        self.presenter?.pressedLoginButton(self.emailTextField.text!, password)
    }
    
    func moveToMain() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showErrorForEmail(with message: String) {
        self.errorLabel.text = message
        self.emailBottomBorderView.backgroundColor = ColorPalette.RedForText
    }
    
    func showErrorForPassword(with message: String) {
        self.errorLabel.text = message
        self.passwordBottomBorderView.backgroundColor = ColorPalette.RedForText
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
        self.centerView.addSubview(self.loginLabel)
        self.loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        // 이메일 텍스트 필드 추가
        self.centerView.addSubview(self.emailTextField)
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.loginLabel.snp.bottom).offset(50)
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
