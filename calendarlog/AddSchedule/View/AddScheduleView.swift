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
    var startDateValue: String = "2018.01.01 00:00" {
        didSet {
            self.startDateTextField.text = startDateValue
        }
    }
    var startYearIndexValue: Int = 0
    var startMonthIndexValue: Int = 0
    var startDayIndexValue: Int = 0 {
        didSet {
            self.startDatePickerView.selectRow(self.startDayIndexValue, inComponent: 2, animated: false)
        }
    }
    var startHourIndexValue: Int = 0
    var startMinuteIndexValue: Int = 0
    
    var endDateValue: String = "2018.01.01 00:00" {
        didSet {
            self.endDateTextField.text = endDateValue
        }
    }
    var endYearIndexValue: Int = 0
    var endMonthIndexValue: Int = 0
    var endDayIndexValue: Int = 0 {
        didSet {
            self.endDatePickerView.selectRow(self.endDayIndexValue, inComponent: 2, animated: false)
        }
    }
    var endHourIndexValue: Int = 0
    var endMinuteIndexValue: Int = 0
    
    let yearInfo = Array(2018...2019)
    let monthInfo = Array(1...12)
    let dayInfo = Array(1...31)
    let hourInfo = Array(0...23)
    let minuteInfo = ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"]
    
    var selectedCategoryValue = -1 {
        didSet {
            self.categoryTextField.textColor = ColorPalette.BlackForText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.startDateTextField.delegate = self
        self.endDateTextField.delegate = self
        self.titleTextField.delegate = self
        self.contentTextView.delegate = self
        self.categoryTextField.delegate = self
        self.locationTextField.delegate = self
        self.urlFirstTextField.delegate = self
        self.urlSecondTextField.delegate = self
        self.urlThirdTextField.delegate = self
        let touchUpInsideTap = UITapGestureRecognizer(target: self, action: #selector(pushImageUploadButton))
        self.scheduleImageView.addGestureRecognizer(touchUpInsideTap)
        //내비게이션바 타이틀 설정
        self.title = "일정 추가"
        // 내비게이션바 우측상단 쪽지 이미지 설정
        let doneBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_done"), style: .done, target: self, action: #selector(self.pushDone))
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
        // 커서 색상 없애기
        textField.tintColor = UIColor.clear
        return textField
    }()
    // 시작일 피커뷰 설정
    let startDatePickerView = UIPickerView()
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
        // 커서 색상 없애기
        textField.tintColor = UIColor.clear
        return textField
    }()
    // 종료일 피커뷰 설정
    let endDatePickerView = UIPickerView()
    // 일자 하단 라인 설정
    let dateBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayLightForBorder
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
        textView.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textView.layer.borderColor = ColorPalette.GrayForBottomBorder.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        return textView
    }()
    // 카테고리 라벨 설정
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.textColor = ColorPalette.BlackForText
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return label
    }()
    // 카테고리 텍스트 필드 설정
    let categoryTextField: UITextField = {
        let textField = UITextField()
        textField.text = "카테고리를 선택해주세요."
        textField.textColor = ColorPalette.GrayForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.textAlignment = .right
        //textField.inputView = nil
        // 커서 색상 없애기
        textField.tintColor = UIColor.clear
        return textField
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
    let imageUploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("이미지 첨부", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        button.backgroundColor = ColorPalette.BlueForButton
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(pushImageUploadButton), for: .touchUpInside)
        return button
    }()
    // 업로드 이미지 뷰 설정
    let scheduleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_placeholder")
        imageView.isUserInteractionEnabled = true
        return imageView
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
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pushImageUploadButton() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionCamera = UIAlertAction(title: "사진 촬영", style: .default, handler: { _ -> Void in
            // 일정 이미지 설정
            self.scheduleImageView.snp.updateConstraints { make in
                make.top.equalTo(self.imageUploadButton.snp.bottom).offset(15)
                make.size.equalTo(200)
            }
            self.scheduleImageView.setNeedsUpdateConstraints()
        })
        let actionAlbum = UIAlertAction(title: "사진 앨범에서 선택", style: .default, handler: { _ -> Void in
            // 일정 이미지 설정
            self.scheduleImageView.snp.updateConstraints { make in
                make.top.equalTo(self.imageUploadButton.snp.bottom).offset(15)
                make.size.equalTo(200)
            }
        })
        let actionDelete = UIAlertAction(title: "사진 제거", style: .default, handler: { _ -> Void in
            // 일정 이미지 설정
            self.scheduleImageView.snp.updateConstraints { make in
                make.top.equalTo(self.imageUploadButton.snp.bottom).offset(0)
                make.size.equalTo(0)
            }
            self.scheduleImageView.layoutIfNeeded()
        })
        let actionCancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        alert.addAction(actionCamera)
        alert.addAction(actionAlbum)
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func findMaxDayIndex(with monthIndex: Int) -> Int {
        //28일 이후로 선택시
        if monthIndex == 1 {
            //2월 = 28일까지
            return 27
        } else if monthIndex == 3 || monthIndex == 5 || monthIndex == 8 || monthIndex == 10 {
            // 4월, 6월, 9월, 11월 = 30일까지
            return 29
        } else {
            return 30
        }
    }
    
    @objc func pushDone() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        let formatterShort = DateFormatter()
        formatterShort.dateFormat = "yyyyMMdd"
        
        let startDate = formatterShort.string(from: formatter.date(from: self.startDateValue)!)
        let endDate = formatterShort.string(from: formatter.date(from: self.endDateValue)!)
        let startDatetime = self.startDateValue
        let endDatetime = self.endDateValue
        let title = self.titleTextField.text!
        let content = self.contentTextView.text == "내용을 입력하세요." ? "" : self.contentTextView.text!
        let imgUrl = ""
        let location = self.locationTextField.text!
        let url1 = self.urlFirstTextField.text!
        let url2 = self.urlSecondTextField.text!
        let url3 = self.urlThirdTextField.text!
        if selectedCategoryValue == -1 {
            self.categoryTextField.textColor = ColorPalette.RedForText
            return
        }
        let category = selectedCategoryValue
        let etc = ""
        let isPublic = isPublicSwitch.isOn
        
        self.presenter?.createSchedule(startDate, endDate, startDatetime, endDatetime, title, content, imgUrl, location,
                                       url1, url2, url3, category, etc, isPublic)
    }
    
    @objc func pushStartDateDone() {
        self.startYearIndexValue = self.startDatePickerView.selectedRow(inComponent: 0)
        self.startMonthIndexValue = self.startDatePickerView.selectedRow(inComponent: 1)
        self.startDayIndexValue = self.startDatePickerView.selectedRow(inComponent: 2)
        let maxDayIndex = findMaxDayIndex(with: self.startMonthIndexValue)
        if maxDayIndex < self.startDayIndexValue {
            self.startDayIndexValue = maxDayIndex
        }
        self.startHourIndexValue = self.startDatePickerView.selectedRow(inComponent: 3)
        self.startMinuteIndexValue = self.startDatePickerView.selectedRow(inComponent: 4)
        let month = self.startMonthIndexValue < 9 ? "0\(self.monthInfo[self.startMonthIndexValue])" : String(self.monthInfo[self.startMonthIndexValue])
        let day = self.startDayIndexValue < 9 ? "0\(self.dayInfo[self.startDayIndexValue])" : String(self.dayInfo[self.startDayIndexValue])
        let hour = self.startHourIndexValue < 10 ? "0\(self.hourInfo[self.startHourIndexValue])" : String(self.hourInfo[self.startHourIndexValue])
        self.startDateValue = "\(self.yearInfo[self.startYearIndexValue]).\(month).\(day) \(hour):\(self.minuteInfo[self.startMinuteIndexValue])"
        self.startDateTextField.resignFirstResponder()
    }
    // MARK: 종료시간 완료 클릭시 DatePicker Dismiss
    @objc func pushEndDateDone() {
        let endYearIndexValue = self.endDatePickerView.selectedRow(inComponent: 0)
        let endMonthIndexValue = self.endDatePickerView.selectedRow(inComponent: 1)
        var endDayIndexValue = self.endDatePickerView.selectedRow(inComponent: 2)
        let maxDayIndex = findMaxDayIndex(with: endMonthIndexValue)
        if maxDayIndex < endDayIndexValue {
            endDayIndexValue = maxDayIndex
        }
        let endHourIndexValue = self.endDatePickerView.selectedRow(inComponent: 3)
        let endMinuteIndexValue = self.endDatePickerView.selectedRow(inComponent: 4)
        let month = endMonthIndexValue < 9 ? "0\(self.monthInfo[endMonthIndexValue])" : String(self.monthInfo[endMonthIndexValue])
        let day = endDayIndexValue < 9 ? "0\(self.dayInfo[endDayIndexValue])" : String(self.dayInfo[endDayIndexValue])
        let hour = endHourIndexValue < 10 ? "0\(self.hourInfo[endHourIndexValue])" : String(self.hourInfo[endHourIndexValue])
        let endDateValue = "\(self.yearInfo[endYearIndexValue]).\(month).\(day) \(hour):\(self.minuteInfo[endMinuteIndexValue])"
        if self.startDateValue > endDateValue {
            SVProgressHUD.showError(withStatus: "시작일자가 종료일자보다 클 수 없습니다.")
            return
        }
        self.endYearIndexValue = endYearIndexValue
        self.endMonthIndexValue = endMonthIndexValue
        self.endDayIndexValue = endDayIndexValue
        self.endHourIndexValue = endHourIndexValue
        self.endMinuteIndexValue = endMinuteIndexValue
        self.endDateValue = endDateValue
        self.endDateTextField.resignFirstResponder()
    }
    
    func setPickerViewWithToolbar(_ textField: UITextField, _ pickerView: UIPickerView,
                                  _ yearIndex: Int, _ monthIndex: Int, _ dayIndex: Int,
                                  _ hourIndex: Int, _ minuteIndex: Int, _ doneButton: UIBarButtonItem) {
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(yearIndex, inComponent: 0, animated: false)
        pickerView.selectRow(monthIndex, inComponent: 1, animated: false)
        pickerView.selectRow(dayIndex, inComponent: 2, animated: false)
        pickerView.selectRow(hourIndex, inComponent: 3, animated: false)
        pickerView.selectRow(minuteIndex, inComponent: 4, animated: false)
        // MARK: Toolbar 설정
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = ColorPalette.Primary
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        textField.inputView = pickerView
        pickerView.delegate = self
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
        self.startDateTextField.text = self.startDateValue
        self.centerView.addSubview(self.startDateTextField)
        self.startDateTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalTo(self.startDateLabel.snp.right)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 시작일 피커뷰 추가
        self.startDatePickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 216)
        let startDateBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_done"), style: .plain, target: self, action: #selector(pushStartDateDone))
        self.setPickerViewWithToolbar(self.startDateTextField, self.startDatePickerView, self.startYearIndexValue, self.startMonthIndexValue, self.startDayIndexValue, self.startHourIndexValue, self.startMinuteIndexValue, startDateBarButtonItem)
        // 종료일 라벨 추가
        self.centerView.addSubview(self.endDateLabel)
        self.endDateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.startDateLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.width.equalTo(80)
        }
        // 종료일 텍스트 필드
        self.endDateTextField.text = self.endDateValue
        self.centerView.addSubview(self.endDateTextField)
        self.endDateTextField.snp.makeConstraints { make in
            make.top.equalTo(self.startDateTextField.snp.bottom).offset(10)
            make.left.equalTo(self.endDateLabel.snp.right)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 종료일 피커뷰 추가
        self.endDatePickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 216)
        let endDateBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_done"), style: .plain, target: self, action: #selector(pushEndDateDone))
        self.setPickerViewWithToolbar(self.endDateTextField, self.endDatePickerView, self.endYearIndexValue, self.endMonthIndexValue, self.endDayIndexValue, self.endHourIndexValue, self.endMinuteIndexValue, endDateBarButtonItem)
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
        // 카테고리 라벨 추가
        self.centerView.addSubview(self.categoryLabel)
        self.categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentTextView.snp.bottom).offset(19)
            make.left.equalToSuperview().offset(offsetLeftValue)
        }
        // 카테고리 텍스트 필드 추가
        self.centerView.addSubview(self.categoryTextField)
        self.categoryTextField.snp.makeConstraints { make in
            make.centerY.equalTo(self.categoryLabel)
            make.left.equalTo(self.categoryLabel.snp.right).offset(0)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 이미지 라벨 추가
        self.centerView.addSubview(self.imageLabel)
        self.imageLabel.snp.makeConstraints { make in
            make.top.equalTo(self.categoryLabel.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(offsetLeftValue)
        }
        // 이미지 첨부 버튼 추가
        self.centerView.addSubview(self.imageUploadButton)
        self.imageUploadButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.imageLabel)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.width.equalTo(110)
        }
        // 업로드 이미지 추가
        self.centerView.addSubview(self.scheduleImageView)
        self.scheduleImageView.snp.makeConstraints { make in
            make.top.equalTo(self.imageUploadButton.snp.bottom).offset(0)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.size.height.equalTo(0)
        }
        // 장소 텍스트 필드 추가
        self.centerView.addSubview(self.locationTextField)
        self.locationTextField.snp.makeConstraints { make in
            make.top.equalTo(self.scheduleImageView.snp.bottom).offset(37)
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
        switch component {
        case 0:
            // year
            return self.yearInfo.count
        case 1:
            // month
            return self.monthInfo.count
        case 2:
            // day
            return self.dayInfo.count
        case 3:
            // hour
            return self.hourInfo.count
        case 4:
            // minute
            return self.minuteInfo.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            // year
            return String(self.yearInfo[row])
        case 1:
            // month
            let month = String(self.monthInfo[row])
            return month.count == 1 ? "0\(month)" : month
        case 2:
            // day
            let day = String(self.dayInfo[row])
            return day.count == 1 ? "0\(day)" : day
        case 3:
            // hour
            let hour = String(self.hourInfo[row])
            return hour.count == 1 ? "0\(hour)" : hour
        case 4:
            // minute
            return self.minuteInfo[row]
        default:
            return "Error"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.startDatePickerView {
            switch component {
            case 0:
                // 년
                self.startYearIndexValue = row
            case 1:
                // 월
                self.startMonthIndexValue = row
                let maxDayIndex = findMaxDayIndex(with: row)
                if maxDayIndex < self.startDayIndexValue {
                    self.startDayIndexValue = maxDayIndex
                }
            case 2:
                // 일
                let maxDayIndex = findMaxDayIndex(with: self.startMonthIndexValue)
                if maxDayIndex < row {
                    self.startDayIndexValue = maxDayIndex
                } else {
                    self.startDayIndexValue = row
                }
            case 3:
                // 시
                self.startHourIndexValue = row
            case 4:
                // 분
                self.startMinuteIndexValue = row
            default:
                ()
            }
        } else {
            switch component {
            case 0:
                // 년
                self.endYearIndexValue = row
            case 1:
                // 월
                self.endMonthIndexValue = row
                let maxDayIndex = findMaxDayIndex(with: row)
                if maxDayIndex < self.endDayIndexValue {
                    self.endDayIndexValue = maxDayIndex
                }
            case 2:
                // 일
                let maxDayIndex = findMaxDayIndex(with: self.endMonthIndexValue)
                if maxDayIndex < row {
                    self.endDayIndexValue = maxDayIndex
                } else {
                    self.endDayIndexValue = row
                }
            case 3:
                // 시
                self.endHourIndexValue = row
            case 4:
                // 분
                self.endMinuteIndexValue = row
            default:
                ()
            }
        }
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
            self.startDateTextField.textColor = ColorPalette.Primary
        case self.endDateTextField:
            self.endDateTextField.textColor = ColorPalette.Primary
        case self.titleTextField:
            self.titleBottomBorderView.backgroundColor = ColorPalette.Primary
        case self.categoryTextField:
            self.categoryTextField.textColor = ColorPalette.Primary
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let actionFirst = UIAlertAction(title: "IT", style: .default, handler: { _ -> Void in
                self.selectedCategoryValue = 1
                self.categoryTextField.text = "IT"
            })
            let actionSecond = UIAlertAction(title: "문화/예술", style: .default, handler: { _ -> Void in
                self.selectedCategoryValue = 2
                self.categoryTextField.text = "문화/예술"
            })
            let actionThird = UIAlertAction(title: "방송/연예", style: .default, handler: { _ -> Void in
                self.selectedCategoryValue = 3
                self.categoryTextField.text = "방송/연예"
            })
            let actionFourth = UIAlertAction(title: "패션/뷰티", style: .default, handler: { _ -> Void in
                self.selectedCategoryValue = 4
                self.categoryTextField.text = "패션/뷰티"
            })
            let actionFifth = UIAlertAction(title: "전시/박람회", style: .default, handler: { _ -> Void in
                self.selectedCategoryValue = 5
                self.categoryTextField.text = "전시/박람회"
            })
            let actionSixth = UIAlertAction(title: "여행/스포츠", style: .default, handler: { _ -> Void in
                self.selectedCategoryValue = 6
                self.categoryTextField.text = "여행/스포츠"
            })
            let actionSeventh = UIAlertAction(title: "기타", style: .default, handler: { _ -> Void in
                self.selectedCategoryValue = 0
                self.categoryTextField.text = "기타"
            })
            alert.addAction(actionFirst)
            alert.addAction(actionSecond)
            alert.addAction(actionThird)
            alert.addAction(actionFourth)
            alert.addAction(actionFifth)
            alert.addAction(actionSixth)
            alert.addAction(actionSeventh)
            self.present(alert, animated: true, completion: { () in
                self.categoryTextField.resignFirstResponder()
            })
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
            self.startDateTextField.textColor = ColorPalette.BlackForText
        case self.endDateTextField:
            self.endDateTextField.textColor = ColorPalette.BlackForText
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
