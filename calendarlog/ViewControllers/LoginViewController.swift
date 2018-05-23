//
//  ViewController.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 4. 4..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class LoginViewController: SuperViewController {
    private var isLoginProcess: Bool = false
    // 로고 설정
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "logo_login.png")
        imageView.image = image
        return imageView
    }()
    // 타이틀 설정
    let titleImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "title_login.png")
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
        textField.textContentType = UITextContentType.emailAddress
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        return textField
    }()
    // 로그인 뷰 이메일 텍스트 필드 하단 라인 설정
    let emailBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 로그인 뷰 비밀번호 텍스트 필드 설정
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.textContentType = UITextContentType.password
        textField.isSecureTextEntry = true
        return textField
    }()
    // 로그인 뷰 비밀번호 텍스트 필드 하단 라인 설정
    let passwordBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 로그인 뷰 오류 텍스트 필드 설정
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        label.textColor = ColorPalette.RedForText
        return label
    }()
    // 로그인 뷰 로그인 혹은 회원가입 버튼 설정
    let loginOrRegisterButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인 혹은 회원가입", for: .normal)
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
        self.passwordTextField.delegate = self
        self.loginOrRegisterButton.addTarget(self, action: #selector(self.pressedLoginOrRegisterButton), for: .touchUpInside)
    }
}

extension LoginViewController {
    func initializeUI() {
        // 로고 이미지 추가
        self.view.addSubview(self.logoImageView)
        self.logoImageView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.top.equalTo(self.view).offset(40)
        }
        // 로고 타이틀 추가
        self.view.addSubview(self.titleImageView)
        self.titleImageView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.top.equalTo(self.logoImageView).offset(60)
        }
        // 로그인 라벨 추가
        self.centerView.addSubview(self.loginLabel)
        self.loginLabel.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.top.equalTo(self.centerView).offset(20)
        }
        // 이메일 텍스트 필드 추가
        self.centerView.addSubview(self.emailTextField)
        self.emailTextField.snp.makeConstraints { view in
            view.top.equalTo(self.loginLabel).offset(70)
            view.left.equalTo(self.centerView).offset(20)
            view.right.equalTo(self.centerView).offset(-20)
        }
        // 이메일 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.emailBottomBorderView)
        self.emailBottomBorderView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.top.equalTo(self.emailTextField).offset(25)
            view.left.equalTo(self.centerView).offset(20)
            view.right.equalTo(self.centerView).offset(-20)
            view.height.equalTo(1)
        }
        // 로그인 혹은 회원가입 버튼 추가
        self.centerView.addSubview(self.loginOrRegisterButton)
        self.loginOrRegisterButton.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.left.equalTo(self.centerView).offset(20)
            view.right.equalTo(self.centerView).offset(-20)
            view.bottom.equalTo(self.centerView).offset(-40)
            view.size.height.equalTo(50)
        }
        // 오류 라벨 추가
        self.centerView.addSubview(self.errorLabel)
        self.errorLabel.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.left.equalTo(self.centerView).offset(20)
            view.right.equalTo(self.centerView).offset(-20)
            view.bottom.equalTo(self.loginOrRegisterButton).offset(-60)
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
    @objc func pressedLoginOrRegisterButton() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
        self.navigationController?.popToRootViewController(animated: true)
        return
        // 오류 문구 초기화
        self.errorLabel.text = ""
        self.emailBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        self.passwordBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        if self.isLoginProcess {
//            self.errorLabel.text = "비밀번호가 일치하지 않습니다."
//            self.passwordBottomBorderView.backgroundColor = ColorPalette.RedForText
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            guard let emailValue = self.emailTextField.text else {
                self.errorLabel.text = "이메일을 입력해주세요."
                self.emailBottomBorderView.backgroundColor = ColorPalette.RedForText
                return
            }
            guard emailValue.count > 0 else {
                self.errorLabel.text = "이메일을 입력해주세요."
                self.emailBottomBorderView.backgroundColor = ColorPalette.RedForText
                return
            }
            let alertViewController = UIAlertController(title: "이동", message: "어디로 갈래?", preferredStyle: .alert)
            let actionLogin = UIAlertAction(title: "로그인으로", style: .default, handler: { _ in
                UIView.animate(withDuration: 2.0) {
                    self.emailTextField.isUserInteractionEnabled = false
                    self.emailTextField.transform = CGAffineTransform(translationX: 0, y: -45)
                    self.emailBottomBorderView.transform = CGAffineTransform(translationX: 0, y: -45)
                    // 비밀번호 텍스트 필드 추가
                    self.centerView.addSubview(self.passwordTextField)
                    self.passwordTextField.snp.makeConstraints { view in
                        view.centerX.equalToSuperview()
                        view.top.equalTo(100)
                        view.left.equalTo(20)
                        view.right.equalTo(-20)
                    }
                    self.passwordTextField.layoutIfNeeded()
                    // 비밀번호 텍스트 필드 하단 라인 추가
                    self.centerView.addSubview(self.passwordBottomBorderView)
                    self.passwordBottomBorderView.snp.makeConstraints { view in
                        view.centerX.equalToSuperview()
                        view.top.equalTo(125)
                        view.left.equalTo(20)
                        view.right.equalTo(-20)
                        view.height.equalTo(1)
                    }
                    self.passwordBottomBorderView.layoutIfNeeded()
                }
                self.isLoginProcess = true
                self.loginOrRegisterButton.setTitle("로그인", for: .normal)
            })
            let actionRegister = UIAlertAction(title: "회원가입으로", style: .default, handler: { _ in
                let registerViewController = RegisterViewController()
                registerViewController.emailValue = emailValue
                self.navigationController?.pushViewController(registerViewController, animated: true)
            })
            alertViewController.addAction(actionRegister)
            alertViewController.addAction(actionLogin)
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    // 텍스트 필드 수정할때 길이 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if newString.length > maxLength {
            self.errorLabel.text = "비밀번호는 15자리까지 입력해주세요."
            self.passwordBottomBorderView.backgroundColor = ColorPalette.RedForText
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
