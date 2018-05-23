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
    // 메인 스크롤 뷰 설정
    let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    // 회원가입 뷰 이메일 텍스트 필드 설정
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = ColorPalette.GrayForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.isUserInteractionEnabled = false
        return textField
    }()
    // 회원가입 뷰 이메일 텍스트 필드 하단 라인 설정
    let emailBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 회원가입 뷰 비밀번호 텍스트 필드 설정
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.textContentType = UITextContentType.password
        textField.isSecureTextEntry = true
        return textField
    }()
    // 회원가입 뷰 비밀번호 텍스트 필드 하단 라인 설정
    let passwordBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 회원가입 뷰 비밀번호 확인 텍스트 필드 설정
    let passwordConfirmTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호 확인", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.textContentType = UITextContentType.password
        textField.isSecureTextEntry = true
        return textField
    }()
    // 회원가입 뷰 비밀번호 확인 텍스트 필드 하단 라인 설정
    let passwordConfirmBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 회원가입 뷰 닉네임 텍스트 필드 설정
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return textField
    }()
    // 회원가입 뷰 닉네임 텍스트 필드 하단 라인 설정
    let nicknameBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 회원가입 뷰 성별 라벨 설정
    let sexLabel: UILabel = {
        let label = UILabel()
        label.text = "성별"
        label.textColor = ColorPalette.BlackForText
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return label
    }()
    // 회원가입 뷰 성별 버튼 설정
    let maleButton: UIButton = {
        let button = UIButton()
        button.setTitle("남자", for: .normal)
        button.setTitleColor(ColorPalette.BlackForText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        button.setImage(UIImage(named: "ic_radio_default"), for: .normal)
        button.setImage(UIImage(named: "ic_radio_selected"), for: .selected)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }()
    // 회원가입 뷰 성별 버튼 설정
    let femailButton: UIButton = {
        let button = UIButton()
        button.setTitle("여자", for: .normal)
        button.setTitleColor(ColorPalette.BlackForText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        button.setImage(UIImage(named: "ic_radio_default"), for: .normal)
        button.setImage(UIImage(named: "ic_radio_selected"), for: .selected)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }()
    // 회원가입 뷰 관심분야 라벨 설정
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "관심분야"
        label.textColor = ColorPalette.BlackForText
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return label
    }()
    // 회원가입 뷰 관심분야 설명 라벨 설정
    let categoryInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "최소 3개 선택"
        label.textColor = ColorPalette.GrayForText
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        return label
    }()
    // 회원가입 뷰 관심분야 스크롤 뷰 설정
    let categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.BackgroundDark
        return view
    }()
    // 회원가입 뷰 단체/기관 텍스트 필드 설정
    let assignedTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "단체 / 기관", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return textField
    }()
    // 회원가입 뷰 단체/기관 텍스트 필드 하단 라인 설정
    let assignedBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 회원가입 뷰 회원가입 버튼 설정
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        button.backgroundColor = ColorPalette.BlueForButton
        button.layer.cornerRadius = 26
        return button
    }()
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
        //내비게이션바 설정
        self.title = "회원가입"
        let imageBack = UIImage(named: "ic_back.png")
        self.navigationController?.navigationBar.backIndicatorImage = imageBack
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imageBack
        // 전달받은 이메일 값 설정
        self.emailTextField.text = self.emailValue
        self.passwordTextField.delegate = self
        self.passwordConfirmTextField.delegate = self
        self.nicknameTextField.delegate = self
        self.maleButton.addTarget(self, action: #selector(self.pressedSexButton), for: .touchUpInside)
        self.femailButton.addTarget(self, action: #selector(self.pressedSexButton), for: .touchUpInside)
    }
}

extension RegisterViewController {
    @objc func pressedSexButton(_ sender: UIButton) {
        switch sender {
        case self.maleButton:
            self.maleButton.isSelected = true
            self.femailButton.isSelected = false
        case self.femailButton:
            self.maleButton.isSelected = false
            self.femailButton.isSelected = true
        default:
            ()
        }
    }
    func initializeUI() {
        // 메인 스크롤 뷰 추가
        view.addSubview(self.mainScrollView)
        self.mainScrollView.snp.makeConstraints { view in
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            view.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
            view.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
            view.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        // 좌,우 간격
        let offsetLeftValue = 20
        let offsetRightValue = -20
        let offsetTopValue = 25
        // 회원가입 뷰 추가
        self.mainScrollView.addSubview(self.centerView)
        self.centerView.snp.makeConstraints { view in
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            view.left.equalTo(self.view).offset(offsetLeftValue)
            view.right.equalTo(self.view).offset(offsetRightValue)
//            view.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
//            view.size.height.equalTo(500)
        }
//        self.mainScrollView.contentSize = CGSize(width: self.view.frame.width, height: 500)
        // 이메일 텍스트 필드 추가
        self.centerView.addSubview(self.emailTextField)
        self.emailTextField.snp.makeConstraints { view in
            view.top.equalTo(self.centerView).offset(offsetTopValue)
            view.left.equalTo(self.centerView).offset(offsetLeftValue)
            view.right.equalTo(self.centerView).offset(offsetRightValue)
        }
        // 이메일 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.emailBottomBorderView)
        self.emailBottomBorderView.snp.makeConstraints { view in
            view.top.equalTo(self.emailTextField).offset(offsetTopValue)
            view.left.equalTo(self.centerView).offset(offsetLeftValue)
            view.right.equalTo(self.centerView).offset(offsetRightValue)
            view.height.equalTo(1)
        }
        // 비밀번호 텍스트 필드 추가
        self.centerView.addSubview(self.passwordTextField)
        self.passwordTextField.snp.makeConstraints { view in
            view.top.equalTo(self.emailBottomBorderView).offset(offsetTopValue - 5)
            view.left.equalTo(self.centerView).offset(offsetLeftValue)
            view.right.equalTo(self.centerView).offset(offsetRightValue)
        }
        // 비밀번호 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.passwordBottomBorderView)
        self.passwordBottomBorderView.snp.makeConstraints { view in
            view.top.equalTo(self.passwordTextField).offset(offsetTopValue)
            view.left.equalTo(self.centerView).offset(offsetLeftValue)
            view.right.equalTo(self.centerView).offset(offsetRightValue)
            view.height.equalTo(1)
        }
        // 비밀번호 확인 텍스트 필드 추가
        self.centerView.addSubview(self.passwordConfirmTextField)
        self.passwordConfirmTextField.snp.makeConstraints { view in
            view.top.equalTo(self.passwordBottomBorderView).offset(offsetTopValue - 5)
            view.left.equalTo(self.centerView).offset(offsetLeftValue)
            view.right.equalTo(self.centerView).offset(offsetRightValue)
        }
        // 비밀번호 확인 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.passwordConfirmBottomBorderView)
        self.passwordConfirmBottomBorderView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.top.equalTo(self.passwordConfirmTextField).offset(offsetTopValue)
            view.left.equalTo(self.centerView).offset(offsetLeftValue)
            view.right.equalTo(self.centerView).offset(offsetRightValue)
            view.height.equalTo(1)
        }
        // 닉네임 텍스트 필드 추가
        self.centerView.addSubview(self.nicknameTextField)
        self.nicknameTextField.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.top.equalTo(self.passwordConfirmBottomBorderView).offset(offsetTopValue - 5)
            view.left.equalTo(self.centerView).offset(offsetLeftValue)
            view.right.equalTo(self.centerView).offset(offsetRightValue)
        }
        // 닉네임 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.nicknameBottomBorderView)
        self.nicknameBottomBorderView.snp.makeConstraints { view in
            view.top.equalTo(self.nicknameTextField).offset(offsetTopValue)
            view.left.equalTo(self.centerView).offset(offsetLeftValue)
            view.right.equalTo(self.centerView).offset(offsetRightValue)
            view.height.equalTo(1)
        }
        // 성별 라벨 추가
        self.centerView.addSubview(self.sexLabel)
        self.sexLabel.snp.makeConstraints { view in
            view.top.equalTo(self.nicknameBottomBorderView).offset(offsetTopValue)
            view.left.equalTo(self.centerView).offset(offsetLeftValue)
        }
        // 남자 버튼 추가
        self.centerView.addSubview(self.maleButton)
        self.maleButton.snp.makeConstraints { view in
            view.top.equalTo(self.nicknameBottomBorderView).offset(offsetTopValue)
            view.left.equalTo(self.sexLabel).offset(68)
            view.width.equalTo(60)
        }
        // 여자 버튼 추가
        self.centerView.addSubview(self.femailButton)
        self.femailButton.snp.makeConstraints { view in
            view.top.equalTo(self.nicknameBottomBorderView).offset(offsetTopValue)
            view.left.equalTo(self.maleButton).offset(68)
            view.width.equalTo(60)
        }
        // 관심분야 라벨 추가
        self.centerView.addSubview(self.categoryLabel)
        self.categoryLabel.snp.makeConstraints { view in
            view.top.equalTo(self.sexLabel).offset(offsetTopValue + 10)
            view.left.equalTo(self.centerView).offset(offsetLeftValue)
        }
        // 관심분야 설명 라벨 추가
        self.centerView.addSubview(self.categoryInfoLabel)
        self.categoryInfoLabel.snp.makeConstraints { view in
            view.centerY.equalTo(self.categoryLabel).offset(1)
            view.left.equalTo(self.categoryLabel).offset(55)
        }
        // 관심분야 뷰 추가
        self.centerView.addSubview(self.categoryView)
        self.categoryView.snp.makeConstraints { view in
            view.top.equalTo(self.categoryLabel).offset(offsetTopValue)
            view.left.equalTo(self.centerView).offset(offsetLeftValue)
            view.right.equalTo(self.centerView).offset(offsetRightValue)
            view.size.height.equalTo(100)
        }
        self.addCategories()
        // 단체/기관 텍스트 필드 추가
        self.centerView.addSubview(self.assignedTextField)
        self.assignedTextField.snp.makeConstraints { view in
            view.top.equalTo(self.categoryView).offset(100 + offsetTopValue)
            view.left.equalTo(self.centerView).offset(offsetLeftValue)
            view.right.equalTo(self.centerView).offset(offsetRightValue)
        }
        // 단체/기관 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.assignedBottomBorderView)
        self.assignedBottomBorderView.snp.makeConstraints { view in
            view.top.equalTo(self.assignedTextField).offset(offsetTopValue - 5)
            view.left.equalTo(self.centerView).offset(offsetLeftValue)
            view.right.equalTo(self.centerView).offset(offsetRightValue)
            view.height.equalTo(1)
        }
        // 가입하기 버튼 추가
        self.centerView.addSubview(self.registerButton)
        self.registerButton.snp.makeConstraints { view in
            view.top.equalTo(self.assignedBottomBorderView).offset(offsetTopValue)
            view.left.equalTo(self.centerView).offset(offsetLeftValue)
            view.right.equalTo(self.centerView).offset(offsetRightValue)
            view.bottom.equalTo(self.centerView).offset(-20)
            view.size.height.equalTo(50)
        }
    }
    @objc func pressedCategoryButton(_ sender: UIButton) {
        sender.isSelected = true
    }
    func addCategories() {
//        for rowIndex in 0..<3 {
//            for columnIndex in 0..<2 {
//                let categoryButton: UIButton = {
//                    let button = UIButton()
//                    button.setTitle("Swift", for: .normal)
//                    button.setTitleColor(ColorPalette.BlackForText, for: .normal)
//                    button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
//                    button.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)
//                    button.setImage(UIImage(named: "ic_checkbox_checked"), for: .selected)
//                    button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
//                    button.contentHorizontalAlignment = .left
//                    return button
//                }()
//                self.categoryView.addSubview(categoryButton)
//                categoryButton.snp.makeConstraints {view in
//                    view.top.equalTo(self.categoryView).offset(10 + (rowIndex * 30))
////                    view.left.equalTo(10 + (columnIndex * (Int) ((self.view.frame.width - 80) / 2)))
//                    view.left.equalTo(self.categoryView).offset(10 + (columnIndex * (Int) ((self.view.frame.width - 90) / 2)))
////                    view.size.width.equalTo(200)
////                    view.size.height.equalTo(100)
//                }
//                categoryButton.addTarget(self, action: #selector(self.pressedCategoryButton), for: .touchUpInside)
//            }
//        }
//        self.categoryView.addSubview(categoryView)
//        categoryView.snp.makeConstraints { view in
//            view.top.equalTo(self.centerView).offset(305)
//            view.left.equalTo(self.centerView).offset(0)
//            view.right.equalTo(self.centerView).offset(0)
//            view.size.height.equalTo(100)
//        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    // 로그인 혹은 회원가입 버튼 눌렀을 경우 함수
    @objc func pressedRegisterButton() {
    }
    // Return Key 눌렀을시 메소드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.pressedRegisterButton()
        // Return Key 버튼으로 다음줄로 가는것 true, false 값 (여기선 다음 텍스트필드로 이동하므로 값이 상관없음)
        return false
    }
    // 텍스트 필드 수정할때 길이 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if newString.length > maxLength {
            //            self.errorLabel.text = "비밀번호는 15자리까지 입력해주세요."
            self.passwordBottomBorderView.backgroundColor = ColorPalette.RedForText
            return false
        }
        return true
    }
    // 텍스트 필드 선택했을 경우 밑줄 색상 변경
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.passwordTextField:
            self.passwordBottomBorderView.backgroundColor = ColorPalette.Primary
        case self.passwordConfirmTextField:
            self.passwordConfirmBottomBorderView.backgroundColor = ColorPalette.Primary
        case self.nicknameTextField:
            self.nicknameBottomBorderView.backgroundColor = ColorPalette.Primary
        case self.assignedTextField:
            self.assignedBottomBorderView.backgroundColor = ColorPalette.Primary
        default:
            ()
        }
        return
    }
    // 텍스트 필드 빠져나갔을 경우 밑줄 색상 변경
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.passwordTextField:
            self.passwordBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        case self.passwordConfirmTextField:
            self.passwordConfirmBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        case self.nicknameTextField:
            self.nicknameBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        case self.assignedTextField:
            self.assignedBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        default:
            ()
        }
    }
}
