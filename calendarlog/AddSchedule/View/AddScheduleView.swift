//
//  AddScheduleView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddScheduleView: SuperViewController {
    var presenter: AddSchedulePresenterProtocol?
    var dateValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.startDateTextField.delegate = self
        self.endDateTextField.delegate = self
        self.titleTextField.delegate = self
        self.contentTextView.delegate = self
        self.locationTextField.delegate = self
        self.urlFirstTextField.delegate = self
        self.urlSecondTextField.delegate = self
        self.urlThirdTextField.delegate = self
        //내비게이션바 타이틀 설정
        self.title = "일정 추가"
        // 내비게이션바 우측상단 쪽지 이미지 설정
        let doneBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_done.png"), style: .done, target: self, action: #selector(self.pushDone))
        self.navigationItem.rightBarButtonItem = doneBarButtonItem
    }
    
    // 메인 스크롤 뷰 설정
    let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    // 일정추가 뷰 설정
    let centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    // 시작일 라벨 설정
    let startDateLabel: UILabel = {
        let label = UILabel()
        label.text = "시작일"
        label.textColor = ColorPalette.GrayForText
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    // 시작일 텍스트 필드 설정
    let startDateTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.isUserInteractionEnabled = false
        textField.text = "2018.01.01 0:00"
        return textField
    }()
    // 종료일 라벨 설정
    let endDateLabel: UILabel = {
        let label = UILabel()
        label.text = "종료일"
        label.textColor = ColorPalette.GrayForText
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    // 종료일 텍스트 필드 설정
    let endDateTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.isUserInteractionEnabled = false
        textField.text = "2018.01.01 23:59"
        return textField
    }()
    // 일자 하단 라인 설정
    let dateBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayLightForBottomBorder
        return view
    }()
    // 제목 텍스트 필드 설정
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "제목을 입력하세요.", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.tag = 1000
        return textField
    }()
    // 제목 텍스트 필드 하단 라인 설정
    let titleBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 내용 텍스트 뷰 설정
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.text = "내용을 입력하세요."
        textView.textColor = ColorPalette.GrayForText
        textView.backgroundColor = .white
        textView.layer.borderColor = ColorPalette.GrayForBottomBorder.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        return textView
    }()
    // 이미지 라벨 설정
    let imageLabel: UILabel = {
        let label = UILabel()
        label.text = "이미지"
        label.textColor = ColorPalette.BlackForText
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    // 이미지 첨부 버튼 설정
    let imageButton: UIButton = {
        let button = UIButton()
        button.setTitle("이미지 첨부", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        button.backgroundColor = ColorPalette.BlueForButton
        button.layer.cornerRadius = 4
        return button
    }()
    // 장소 텍스트 필드 설정
    let locationTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "장소를 입력하세요.", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.tag = 1001
        return textField
    }()
    // 장소 텍스트 필드 하단 라인 설정
    let locationBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // URL1 텍스트 필드 설정
    let urlFirstTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "URL 1", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.tag = 1002
        return textField
    }()
    // URL1 텍스트 필드 하단 라인 설정
    let urlFirstBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // URL2 텍스트 필드 설정
    let urlSecondTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "URL 2", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.tag = 1003
        return textField
    }()
    // URL2 텍스트 필드 하단 라인 설정
    let urlSecondBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // URL3 텍스트 필드 설정
    let urlThirdTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "URL 3", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.tag = 1004
        return textField
    }()
    // URL3 텍스트 필드 하단 라인 설정
    let urlThirdBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 게시글 공개 여부 라벨 설정
    let isPublicLabel: UILabel = {
        let label = UILabel()
        label.text = "게시글 공개"
        label.textColor = ColorPalette.BlackForText
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    // 게시글 공개 여부 스위치 설정
    let isPublicSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.onTintColor = ColorPalette.Orange
        uiSwitch.isOn = true
        return uiSwitch
    }()
}

extension AddScheduleView: AddScheduleViewProtocol {    
    @objc func pushDone() {
        
    }
    
    func setPickerViewWithToolbar(_ textField: UITextField, _ pickerView: UIPickerView,
                                  _ yearIndex: Int, _ monthIndex: Int, _ dayIndex: Int,
                                  hourIndex: Int, minuteIndex: Int, _ doneButton: UIBarButtonItem) {
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(hourIndex, inComponent: 0, animated: false)
        pickerView.selectRow(minuteIndex, inComponent: 1, animated: false)
        // MARK: Toolbar 설정
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.backgroundColor = UIColor.white
        toolbar.isTranslucent = true
        toolbar.tintColor = ColorPalette.Primary
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        textField.inputView = pickerView
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
        // 상, 좌, 우 간격
        let offsetLeftValue = 20
        let offsetRightValue = -20
        // 일정추가 뷰 추가
        self.mainScrollView.addSubview(self.centerView)
        self.centerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalToSuperview()
        }
        // 시작일 라벨 추가
        self.centerView.addSubview(self.startDateLabel)
        self.startDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.width.equalTo(80)
        }
        // 시작일 텍스트 필드 추가
        //self.setPickerViewWithToolbar(self.textFieldStartTime, self.pickerViewStartTime, self.startTimeHourIndex, self.startTimeMinuteIndex, doneButtonStartTime)
        self.centerView.addSubview(self.startDateTextField)
        self.startDateTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalTo(self.startDateLabel.snp.right)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 종료일 라벨 추가
        self.centerView.addSubview(self.endDateLabel)
        self.endDateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.startDateLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.width.equalTo(80)
        }
        // 종료일 텍스트 필드
        //self.setPickerViewWithToolbar(self.textFieldStartTime, self.pickerViewStartTime, self.startTimeHourIndex, self.startTimeMinuteIndex, doneButtonStartTime)
        self.centerView.addSubview(self.endDateTextField)
        self.endDateTextField.snp.makeConstraints { make in
            make.top.equalTo(self.startDateTextField.snp.bottom).offset(10)
            make.left.equalTo(self.endDateLabel.snp.right)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 일자 하단 라인 추가
        self.centerView.addSubview(self.dateBottomBorderView)
        self.dateBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.endDateLabel.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(7)
        }
        // 제목 텍스트 필드 추가
        self.centerView.addSubview(self.titleTextField)
        self.titleTextField.snp.makeConstraints { make in
            make.top.equalTo(self.dateBottomBorderView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 제목 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.titleBottomBorderView)
        self.titleBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.titleTextField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(offsetLeftValue - 5)
            make.right.equalToSuperview().offset(offsetRightValue + 5)
            make.height.equalTo(1)
        }
        // 내용 텍스트 뷰 추가
        self.centerView.addSubview(self.contentTextView)
        self.contentTextView.snp.makeConstraints { make in
            make.top.equalTo(self.titleBottomBorderView.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(offsetLeftValue - 5)
            make.right.equalToSuperview().offset(offsetRightValue + 5)
            make.height.equalTo(120)
        }
        // 이미지 라벨 추가
        self.centerView.addSubview(self.imageLabel)
        self.imageLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentTextView.snp.bottom).offset(19)
            make.left.equalToSuperview().offset(offsetLeftValue)
        }
        // 이미지 첨부 버튼 추가
        self.centerView.addSubview(self.imageButton)
        self.imageButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.imageLabel)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.width.equalTo(110)
        }
        // 장소 텍스트 필드 추가
        self.centerView.addSubview(self.locationTextField)
        self.locationTextField.snp.makeConstraints { make in
            make.top.equalTo(self.imageLabel.snp.bottom).offset(37)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 장소 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.locationBottomBorderView)
        self.locationBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.locationTextField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(offsetLeftValue - 5)
            make.right.equalToSuperview().offset(offsetRightValue + 5)
            make.height.equalTo(1)
        }
        // URL 1 텍스트 필드 추가
        self.centerView.addSubview(self.urlFirstTextField)
        self.urlFirstTextField.snp.makeConstraints { make in
            make.top.equalTo(self.locationBottomBorderView).offset(28)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // URL 1 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.urlFirstBottomBorderView)
        self.urlFirstBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.urlFirstTextField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(offsetLeftValue - 5)
            make.right.equalToSuperview().offset(offsetRightValue + 5)
            make.height.equalTo(1)
        }
        // URL 2 텍스트 필드 추가
        self.centerView.addSubview(self.urlSecondTextField)
        self.urlSecondTextField.snp.makeConstraints { make in
            make.top.equalTo(self.urlFirstBottomBorderView).offset(12)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // URL 2 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.urlSecondBottomBorderView)
        self.urlSecondBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.urlSecondTextField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(offsetLeftValue - 5)
            make.right.equalToSuperview().offset(offsetRightValue + 5)
            make.height.equalTo(1)
        }
        // URL 3 텍스트 필드 추가
        self.centerView.addSubview(self.urlThirdTextField)
        self.urlThirdTextField.snp.makeConstraints { make in
            make.top.equalTo(self.urlSecondBottomBorderView).offset(12)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // URL 3 텍스트 필드 하단 라인 추가
        self.centerView.addSubview(self.urlThirdBottomBorderView)
        self.urlThirdBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.urlThirdTextField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(offsetLeftValue - 5)
            make.right.equalToSuperview().offset(offsetRightValue + 5)
            make.height.equalTo(1)
        }
        // 게시글 공개 여부 라벨 추가
        self.centerView.addSubview(self.isPublicLabel)
        self.isPublicLabel.snp.makeConstraints { make in
            make.top.equalTo(self.urlThirdBottomBorderView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.bottom.equalToSuperview().offset(-30)
        }
        // 게시글 공개 여부 스위치 추가
        self.centerView.addSubview(self.isPublicSwitch)
        self.isPublicSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(self.isPublicLabel)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
    }
}

extension AddScheduleView: UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "내용을 입력하세요." {
            textView.text.removeAll()
            textView.textColor = ColorPalette.BlackForText
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "내용을 입력하세요."
            textView.textColor = ColorPalette.GrayForText
        }
    }
    
    // 텍스트 필드 수정할때 길이 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        switch textField {
        case self.titleTextField:
            if newString.length > 50 {
                SVProgressHUD.showError(withStatus: "제목은 50자리까지 입력해주세요.")
                return false
            }
        case self.locationTextField:
            if newString.length > 100 {
                SVProgressHUD.showError(withStatus: "장소는 100자리까지 입력해주세요.")
                return false
            }
        default:
            ()
        }
        return true
    }
    
    // MARK: Return Key 눌렀을시 메소드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Tag = 1000 = 제목일때는 내용으로 넘어가도록
        if textField.tag == 1000 {
            self.contentTextView.becomeFirstResponder()
            return false
        }
        // 태그 값 다음 찾을시 이동
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // 태그 값 다음 못찾을시 키보드 없애기
            textField.resignFirstResponder()
        }
        // Return Key 버튼으로 다음줄로 가는것 true, false 값 (여기선 다음 텍스트필드로 이동하므로 값이 상관없음)
        return false
    }
    
    // 텍스트 필드 선택했을 경우 밑줄 색상 변경
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.startDateTextField:
            self.startDateTextField.backgroundColor = ColorPalette.Primary
        case self.endDateTextField:
            self.endDateTextField.backgroundColor = ColorPalette.Primary
        case self.titleTextField:
            self.titleBottomBorderView.backgroundColor = ColorPalette.Primary
        case self.locationTextField:
            self.locationBottomBorderView.backgroundColor = ColorPalette.Primary
        case self.urlFirstTextField:
            self.urlFirstBottomBorderView.backgroundColor = ColorPalette.Primary
        case self.urlSecondTextField:
            self.urlSecondBottomBorderView.backgroundColor = ColorPalette.Primary
        case self.urlThirdTextField:
            self.urlThirdBottomBorderView.backgroundColor = ColorPalette.Primary
        default:
            ()
        }
        return
    }
    
    // 텍스트 필드 빠져나갔을 경우 밑줄 색상 변경
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.startDateTextField:
            self.startDateTextField.backgroundColor = ColorPalette.GrayForBottomBorder
        case self.endDateTextField:
            self.endDateTextField.backgroundColor = ColorPalette.GrayForBottomBorder
        case self.titleTextField:
            self.titleBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        case self.locationTextField:
            self.locationBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        case self.urlFirstTextField:
            self.urlFirstBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        case self.urlSecondTextField:
            self.urlSecondBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        case self.urlThirdTextField:
            self.urlThirdBottomBorderView.backgroundColor = ColorPalette.GrayForBottomBorder
        default:
            ()
        }
    }
}
