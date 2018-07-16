//
//  RegisterView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 27..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit
import SVProgressHUD

class RegisterView: SuperViewController {
    var presenter: RegisterPresenterProtocol?
    var emailValue = ""
    var categoryTuples: [(Int, Int)] = [(0, 0), (1, 0), (2, 0), (3, 0), (4, 0), (5, 0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        //내비게이션바 타이틀 설정
        self.title = "회원가입"
        // 전달받은 이메일 값 설정
        self.emailTextField.text = self.emailValue
        self.passwordTextField.delegate = self
        self.passwordConfirmTextField.delegate = self
        self.nicknameTextField.delegate = self
        self.associateTextField.delegate = self
        self.maleButton.addTarget(self, action: #selector(self.pressedSexButton), for: .touchUpInside)
        self.femailButton.addTarget(self, action: #selector(self.pressedSexButton), for: .touchUpInside)
        self.categoryButton0.addTarget(self, action: #selector(self.pressedCategoryButton), for: .touchUpInside)
        self.categoryButton1.addTarget(self, action: #selector(self.pressedCategoryButton), for: .touchUpInside)
        self.categoryButton2.addTarget(self, action: #selector(self.pressedCategoryButton), for: .touchUpInside)
        self.categoryButton3.addTarget(self, action: #selector(self.pressedCategoryButton), for: .touchUpInside)
        self.categoryButton4.addTarget(self, action: #selector(self.pressedCategoryButton), for: .touchUpInside)
        self.categoryButton5.addTarget(self, action: #selector(self.pressedCategoryButton), for: .touchUpInside)
        self.registerButton.addTarget(self, action: #selector(self.pressedRegisterButton), for: .touchUpInside)
    }
    
    // 메인 스크롤 뷰 설정
    let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    // 회원가입 뷰 설정
    let centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 19
        return view
    }()
    // 이메일 텍스트 필드 설정
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = ColorPalette.GrayForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.isUserInteractionEnabled = false
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
        textField.tag = 1000
        return textField
    }()
    // 비밀번호 텍스트 필드 하단 라인 설정
    let passwordBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 비밀번호 확인 텍스트 필드 설정
    let passwordConfirmTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호 확인", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.textContentType = UITextContentType.password
        textField.isSecureTextEntry = true
        textField.tag = 1001
        return textField
    }()
    // 비밀번호 확인 텍스트 필드 하단 라인 설정
    let passwordConfirmBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 닉네임 텍스트 필드 설정
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.tag = 1002
        return textField
    }()
    // 닉네임 텍스트 필드 하단 라인 설정
    let nicknameBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 성별 라벨 설정
    let sexLabel: UILabel = {
        let label = UILabel()
        label.text = "성별"
        label.textColor = ColorPalette.BlackForText
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return label
    }()
    // 남자 버튼 설정
    let maleButton: UIButton = {
        let button = UIButton()
        button.setTitle("남자", for: .normal)
        button.setTitleColor(ColorPalette.BlackForText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        button.setImage(UIImage(named: "ic_radio_default"), for: .normal)
        button.setImage(UIImage(named: "ic_radio_selected"), for: .selected)
        button.isSelected = true
        return button
    }()
    // 여자 버튼 설정
    let femailButton: UIButton = {
        let button = UIButton()
        button.setTitle("여자", for: .normal)
        button.setTitleColor(ColorPalette.BlackForText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        button.setImage(UIImage(named: "ic_radio_default"), for: .normal)
        button.setImage(UIImage(named: "ic_radio_selected"), for: .selected)
        return button
    }()
    // 관심분야 라벨 설정
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "관심분야"
        label.textColor = ColorPalette.BlackForText
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        return label
    }()
    // 관심분야 설명 라벨 설정
    let categoryInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "최소 3개 선택"
        label.textColor = ColorPalette.GrayForText
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        return label
    }()
    // 관심분야 뷰 설정
    let categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.BackgroundDark
        return view
    }()
    let categoryButton0: UIButton = {
        let button = UIButton()
        button.setTitle("자바스크립트", for: .normal)
        button.setTitleColor(ColorPalette.BlackForText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        button.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)
        button.setImage(UIImage(named: "ic_checkbox_checked"), for: .selected)
        button.contentHorizontalAlignment = .left
        button.tag = 0
        return button
    }()
    let categoryButton1: UIButton = {
        let button = UIButton()
        button.setTitle("자바", for: .normal)
        button.setTitleColor(ColorPalette.BlackForText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        button.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)
        button.setImage(UIImage(named: "ic_checkbox_checked"), for: .selected)
        button.contentHorizontalAlignment = .left
        button.tag = 1
        return button
    }()
    let categoryButton2: UIButton = {
        let button = UIButton()
        button.setTitle("코틀린", for: .normal)
        button.setTitleColor(ColorPalette.BlackForText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        button.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)
        button.setImage(UIImage(named: "ic_checkbox_checked"), for: .selected)
        button.contentHorizontalAlignment = .left
        button.tag = 2
        return button
    }()
    let categoryButton3: UIButton = {
        let button = UIButton()
        button.setTitle("스위프트", for: .normal)
        button.setTitleColor(ColorPalette.BlackForText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        button.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)
        button.setImage(UIImage(named: "ic_checkbox_checked"), for: .selected)
        button.contentHorizontalAlignment = .left
        button.tag = 3
        return button
    }()
    let categoryButton4: UIButton = {
        let button = UIButton()
        button.setTitle("파이썬", for: .normal)
        button.setTitleColor(ColorPalette.BlackForText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        button.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)
        button.setImage(UIImage(named: "ic_checkbox_checked"), for: .selected)
        button.contentHorizontalAlignment = .left
        button.tag = 4
        return button
    }()
    let categoryButton5: UIButton = {
        let button = UIButton()
        button.setTitle("스칼라", for: .normal)
        button.setTitleColor(ColorPalette.BlackForText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        button.setImage(UIImage(named: "ic_checkbox_default"), for: .normal)
        button.setImage(UIImage(named: "ic_checkbox_checked"), for: .selected)
        button.contentHorizontalAlignment = .left
        button.tag = 5
        return button
    }()
    // 단체/기관 텍스트 필드 설정
    let associateTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "단체 / 기관", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.tag = 1003
        return textField
    }()
    // 단체/기관 텍스트 필드 하단 라인 설정
    let associateBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 회원가입 버튼 설정
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        button.backgroundColor = ColorPalette.BlueForButton
        button.layer.cornerRadius = 26
        return button
    }()
}

extension RegisterView: RegisterViewProtocol {
    // 로그인 혹은 회원가입 버튼 눌렀을 경우 함수
    @objc func pressedRegisterButton() {
        self.presenter?.pressedRegisterButton(self.emailValue,
                                              self.passwordTextField.text!,
                                              self.passwordConfirmTextField.text!,
                                              self.nicknameTextField.text!,
                                              self.maleButton.isSelected ? "M" : "F",
                                              self.categoryTuples,
                                              self.associateTextField.text!)
    }
    
    func addCategories() {
        let viewWidthSize = self.view.bounds.width - 60
        let buttonWidthSize = viewWidthSize / 3
        self.categoryView.addSubview(self.categoryButton0)
        self.categoryButton0.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(buttonWidthSize + 5)
        }
        self.categoryView.addSubview(self.categoryButton1)
        self.categoryButton1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(self.categoryButton0.snp.right)
            make.width.equalTo(buttonWidthSize - 15)
        }
        self.categoryView.addSubview(self.categoryButton2)
        self.categoryButton2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(self.categoryButton1.snp.right)
            make.width.equalTo(buttonWidthSize)
        }
        self.categoryView.addSubview(self.categoryButton3)
        self.categoryButton3.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(buttonWidthSize + 5)
        }
        self.categoryView.addSubview(self.categoryButton4)
        self.categoryButton4.snp.makeConstraints { make in
            make.left.equalTo(self.categoryButton3.snp.right)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(buttonWidthSize - 15)
        }
        self.categoryView.addSubview(self.categoryButton5)
        self.categoryButton5.snp.makeConstraints { make in
            make.left.equalTo(self.categoryButton4.snp.right)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(buttonWidthSize)
        }
    }
    func initializeUI() {
        // 윗 쪽 파랑배경 설정
        let backgroundTopimageView: UIImageView = UIImageView()
        if let backgroundTopImage = UIImage(named: "background_top.png") {
            backgroundTopimageView.image = backgroundTopImage
        }
        self.view.addSubview(backgroundTopimageView)
        backgroundTopimageView.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(self.view.frame.height / 2.5)
        }
        // 메인 스크롤 뷰 추가
        self.view.addSubview(self.mainScrollView)
        self.mainScrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        // 상, 좌, 우 간격
        let offsetLeftValue = 20
        let offsetRightValue = -20
        // 회원가입 뷰 추가
        self.mainScrollView.addSubview(self.centerView)
        self.centerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(self.view).offset(offsetLeftValue)
            make.right.equalTo(self.view).offset(offsetRightValue)
            make.bottom.equalToSuperview()
        }
        // 이메일 텍스트 필드 추가
        self.centerView.addSubview(self.emailTextField)
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 이메일 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.emailBottomBorderView)
        self.emailBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.emailTextField.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.height.equalTo(1)
        }
        // 비밀번호 텍스트 필드 추가
        self.centerView.addSubview(self.passwordTextField)
        self.passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(self.emailBottomBorderView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 비밀번호 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.passwordBottomBorderView)
        self.passwordBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.height.equalTo(1)
        }
        // 비밀번호 확인 텍스트 필드 추가
        self.centerView.addSubview(self.passwordConfirmTextField)
        self.passwordConfirmTextField.snp.makeConstraints { make in
            make.top.equalTo(self.passwordBottomBorderView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 비밀번호 확인 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.passwordConfirmBottomBorderView)
        self.passwordConfirmBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.passwordConfirmTextField.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.height.equalTo(1)
        }
        // 닉네임 텍스트 필드 추가
        self.centerView.addSubview(self.nicknameTextField)
        self.nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.passwordConfirmBottomBorderView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 닉네임 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.nicknameBottomBorderView)
        self.nicknameBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.nicknameTextField.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.height.equalTo(1)
        }
        // 성별 라벨 추가
        self.centerView.addSubview(self.sexLabel)
        self.sexLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nicknameBottomBorderView.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(offsetLeftValue)
        }
        // 남자 버튼 추가
        self.centerView.addSubview(self.maleButton)
        self.maleButton.snp.makeConstraints { make in
            make.top.equalTo(self.nicknameBottomBorderView.snp.bottom).offset(25)
            make.left.equalTo(self.sexLabel.snp.right).offset(40)
            make.width.equalTo(60)
        }
        // 여자 버튼 추가
        self.centerView.addSubview(self.femailButton)
        self.femailButton.snp.makeConstraints { make in
            make.top.equalTo(self.nicknameBottomBorderView.snp.bottom).offset(25)
            make.left.equalTo(self.maleButton.snp.right).offset(30)
            make.width.equalTo(60)
        }
        // 관심분야 라벨 추가
        self.centerView.addSubview(self.categoryLabel)
        self.categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(self.sexLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(offsetLeftValue)
        }
        // 관심분야 설명 라벨 추가
        self.centerView.addSubview(self.categoryInfoLabel)
        self.categoryInfoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.categoryLabel).offset(0.5)
            make.left.equalTo(self.categoryLabel.snp.right).offset(15)
        }
        // 관심분야 뷰 추가
        self.centerView.addSubview(self.categoryView)
        self.categoryView.snp.makeConstraints { make in
            make.top.equalTo(self.categoryLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.size.height.equalTo(100)
        }
        self.addCategories()
        // 단체/기관 텍스트 필드 추가
        self.centerView.addSubview(self.associateTextField)
        self.associateTextField.snp.makeConstraints { make in
            make.top.equalTo(self.categoryView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 단체/기관 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.associateBottomBorderView)
        self.associateBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.associateTextField.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.size.height.equalTo(1)
        }
        // 가입하기 버튼 추가
        self.centerView.addSubview(self.registerButton)
        self.registerButton.snp.makeConstraints { make in
            make.top.equalTo(self.associateBottomBorderView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.bottom.equalToSuperview().offset(-20)
            make.size.height.equalTo(50)
        }
    }
}

extension RegisterView: UITextFieldDelegate {
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
    
    @objc func pressedCategoryButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.categoryTuples[sender.tag].1 = 0
        } else {
            sender.isSelected = true
            self.categoryTuples[sender.tag].1 = 1
        }
    }
    // Return Key 눌렀을시 메소드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 태그 값 다음 찾을시 이동
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // 태그 값 다음 못찾을시 키보드 없애기
            textField.resignFirstResponder()
            self.pressedRegisterButton()
        }
        // Return Key 버튼으로 다음줄로 가는것 true, false 값
        return false
    }
    
    // 텍스트 필드 수정할때 길이 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        switch textField {
        case self.passwordTextField:
            if newString.length > 15 {
                SVProgressHUD.showError(withStatus: "비밀번호는 15자리까지 입력해주세요.")
                return false
            }
        case self.passwordConfirmTextField:
            if newString.length > 15 {
                SVProgressHUD.showError(withStatus: "비밀번호 획인은 15자리까지 입력해주세요.")
                return false
            }
        case self.nicknameTextField:
            if newString.length > 15 {
                SVProgressHUD.showError(withStatus: "닉네임은 15자리까지 입력해주세요.")
                return false
            }
        case self.associateTextField:
            if newString.length > 20 {
                SVProgressHUD.showError(withStatus: "단체 / 기관은 20자리까지 입력해주세요.")
                return false
            }
        default:
            ()
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
        case self.associateTextField:
            self.associateBottomBorderView.backgroundColor = ColorPalette.Primary
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
        case self.associateTextField:
            self.associateBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        default:
            ()
        }
    }
}
