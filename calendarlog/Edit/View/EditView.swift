//
//  EditView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit
import SVProgressHUD

class EditView: SuperViewController {
    var presenter: EditPresenterProtocol?
    var categoryTuples: [(Int, Int)] = [(0, 0), (1, 0), (2, 0), (3, 0), (4, 0), (5, 0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        //내비게이션바 타이틀 설정
        self.title = "계정정보 수정"
        self.originalPasswordTextField.delegate = self
        self.newPasswordTextField.delegate = self
        self.newPasswordConfirmTextField.delegate = self
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
        // 내비게이션바 우측상단 저장 이미지 설정
        let doneBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_done"), style: .done, target: self, action: #selector(self.pushDone))
        self.navigationItem.rightBarButtonItem = doneBarButtonItem
    }
    // 메인 스크롤 뷰 설정
    let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    // 계정정보 수정 뷰 설정
    let centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // 이메일 라벨 설정
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.BlackForText
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        label.isUserInteractionEnabled = false
        label.text = UserDefaults.standard.string(forKey: "email")
        return label
    }()
    // 기존 비밀번호 텍스트 필드 설정
    let originalPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "기존 비밀번호", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.textContentType = UITextContentType.password
        textField.isSecureTextEntry = true
        textField.tag = 1000
        return textField
    }()
    // 기존 비밀번호 텍스트 필드 하단 라인 설정
    let originalPasswordBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 신규 비밀번호 텍스트 필드 설정
    let newPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "신규 비밀번호", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.textContentType = UITextContentType.password
        textField.isSecureTextEntry = true
        textField.tag = 1001
        return textField
    }()
    // 신규 비밀번호 텍스트 필드 하단 라인 설정
    let newPasswordBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 신규 비밀번호 확인 텍스트 필드 설정
    let newPasswordConfirmTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "신규 비밀번호 확인", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.textContentType = UITextContentType.password
        textField.isSecureTextEntry = true
        textField.tag = 1002
        return textField
    }()
    // 신규 비밀번호 확인 텍스트 필드 하단 라인 설정
    let newPasswordConfirmBottomBorderView: UIView = {
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
        textField.tag = 1003
        textField.text = UserDefaults.standard.string(forKey: "nickname")
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
        button.setTitle("IT", for: .normal)
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
        button.setTitle("문화/예술", for: .normal)
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
        button.setTitle("방송/연예", for: .normal)
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
        button.setTitle("패션/뷰티", for: .normal)
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
        button.setTitle("전시/박람회", for: .normal)
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
        button.setTitle("여행/스포츠", for: .normal)
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
        textField.tag = 1004
        textField.text = "asociate"
        return textField
    }()
    // 단체/기관 텍스트 필드 하단 라인 설정
    let associateBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
}

extension EditView: EditViewProtocol {
    func setEditUserInfo(_ sex: String, _ categories: [Int], _ associate: String) {
        if sex == "M" {
            self.maleButton.isSelected = true
            self.femailButton.isSelected = false
        } else {
            self.maleButton.isSelected = false
            self.femailButton.isSelected = true
        }
        for category in categories {
            switch category {
            case 0:
                self.categoryButton0.isSelected = true
            case 1:
                self.categoryButton1.isSelected = true
            case 2:
                self.categoryButton2.isSelected = true
            case 3:
                self.categoryButton3.isSelected = true
            case 4:
                self.categoryButton4.isSelected = true
            case 5:
                self.categoryButton5.isSelected = true
            default:
                ()
            }
            self.categoryTuples[category].1 = 1
        }
        
        self.associateTextField.text = associate
    }
    
    @objc func pushDone() {
        ()
    }
    
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
    
    func addCategories() {
        let viewWidthSize = self.view.bounds.width - 60
        let buttonWidthSize = viewWidthSize / 3
        self.categoryView.addSubview(self.categoryButton0)
        self.categoryButton0.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(buttonWidthSize)
        }
        self.categoryView.addSubview(self.categoryButton1)
        self.categoryButton1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(self.categoryButton0.snp.right)
            make.width.equalTo(buttonWidthSize)
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
            make.width.equalTo(buttonWidthSize)
        }
        self.categoryView.addSubview(self.categoryButton4)
        self.categoryButton4.snp.makeConstraints { make in
            make.left.equalTo(self.categoryButton3.snp.right)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(buttonWidthSize)
        }
        self.categoryView.addSubview(self.categoryButton5)
        self.categoryButton5.snp.makeConstraints { make in
            make.left.equalTo(self.categoryButton4.snp.right)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(buttonWidthSize)
        }
    }
    
    func initializeUI() {
        self.view.backgroundColor = .white
        // 메인 스크롤 뷰 추가
        self.view.addSubview(self.mainScrollView)
        self.mainScrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        // 계정정보 수정 뷰 추가
        self.mainScrollView.addSubview(self.centerView)
        self.centerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.bottom.equalToSuperview()
        }
        // 이메일 라벨 추가
        self.centerView.addSubview(self.emailLabel)
        self.emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        // 기존 비밀번호 텍스트 필드 추가
        self.centerView.addSubview(self.originalPasswordTextField)
        self.originalPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(self.emailLabel.snp.bottom).offset(25)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        // 기존 비밀번호 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.originalPasswordBottomBorderView)
        self.originalPasswordBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.originalPasswordTextField.snp.bottom).offset(4)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(1)
        }
        // 신규 비밀번호 텍스트 필드 추가
        self.centerView.addSubview(self.newPasswordTextField)
        self.newPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(self.originalPasswordBottomBorderView.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        // 신규 비밀번호 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.newPasswordBottomBorderView)
        self.newPasswordBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.newPasswordTextField.snp.bottom).offset(4)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(1)
        }
        // 신규 비밀번호 확인 텍스트 필드 추가
        self.centerView.addSubview(self.newPasswordConfirmTextField)
        self.newPasswordConfirmTextField.snp.makeConstraints { make in
            make.top.equalTo(self.newPasswordBottomBorderView.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        // 신규 비밀번호 확인 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.newPasswordConfirmBottomBorderView)
        self.newPasswordConfirmBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.newPasswordConfirmTextField.snp.bottom).offset(4)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(1)
        }
        // 닉네임 텍스트 필드 추가
        self.centerView.addSubview(self.nicknameTextField)
        self.nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.newPasswordConfirmBottomBorderView.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        // 닉네임 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.nicknameBottomBorderView)
        self.nicknameBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.nicknameTextField.snp.bottom).offset(4)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(1)
        }
        // 성별 라벨 추가
        self.centerView.addSubview(self.sexLabel)
        self.sexLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nicknameBottomBorderView.snp.bottom).offset(25)
            make.left.equalToSuperview()
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
            make.left.equalToSuperview()
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
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.size.height.equalTo(100)
        }
        self.addCategories()
        // 단체/기관 텍스트 필드 추가
        self.centerView.addSubview(self.associateTextField)
        self.associateTextField.snp.makeConstraints { make in
            make.top.equalTo(self.categoryView.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        // 단체/기관 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.associateBottomBorderView)
        self.associateBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.associateTextField.snp.bottom).offset(4)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.size.height.equalTo(1)
        }
    }
}

extension EditView: UITextFieldDelegate {
    // Return Key 눌렀을시 메소드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 태그 값 다음 찾을시 이동
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // 태그 값 다음 못찾을시 키보드 없애기
            textField.resignFirstResponder()
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
        case self.originalPasswordTextField:
            if newString.length > 15 {
                SVProgressHUD.showError(withStatus: "기존 비밀번호는 15자리까지 입력해주세요.")
                return false
            }
        case self.newPasswordTextField:
            if newString.length > 15 {
                SVProgressHUD.showError(withStatus: "신규 비밀번호는 15자리까지 입력해주세요.")
                return false
            }
        case self.newPasswordConfirmTextField:
            if newString.length > 15 {
                SVProgressHUD.showError(withStatus: "신규 비밀번호 획인은 15자리까지 입력해주세요.")
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
        case self.originalPasswordTextField:
            self.originalPasswordBottomBorderView.backgroundColor = ColorPalette.Primary
        case self.newPasswordTextField:
            self.newPasswordBottomBorderView.backgroundColor = ColorPalette.Primary
        case self.newPasswordConfirmTextField:
            self.newPasswordConfirmBottomBorderView.backgroundColor = ColorPalette.Primary
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
        case self.originalPasswordTextField:
            self.originalPasswordBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        case self.newPasswordTextField:
            self.newPasswordBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        case self.newPasswordConfirmTextField:
            self.newPasswordConfirmBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        case self.nicknameTextField:
            self.nicknameBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        case self.associateTextField:
            self.associateBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        default:
            ()
        }
    }
}
