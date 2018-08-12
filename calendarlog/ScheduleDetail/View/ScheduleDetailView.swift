//
//  ScheduleDetailView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class ScheduleDetailView: SuperViewController {
    var presenter: ScheduleDetailPresenterProtocol?
    var feedValue: Feed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        //////////////////////////////////////////////////////
//        // 내용 높이 맞추기
//        let sizeThatFits = self.contentTextView.sizeThatFits(CGSize(width: self.view.frame.width, height: CGFloat(MAXFLOAT)))
//        self.contentTextView.snp.updateConstraints { make in
//            make.height.equalTo(sizeThatFits)
//        }
        //////////////////////////////////////////////////////
        // 내비게이션바 우측상단 수정 이미지 설정
        let editBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_edit"), style: .done, target: self, action: #selector(self.pushEdit))
        self.navigationItem.rightBarButtonItem = editBarButtonItem
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
    // 스케줄 이미지 뷰 설정
    let scheduleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_placeholder")
        imageView.isUserInteractionEnabled = true
        return imageView
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
        textField.text = "2018.01.01 00:00"
        textField.isUserInteractionEnabled = false
        // 커서 색상 없애기
        textField.tintColor = UIColor.clear
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
        textField.text = "2018.01.01 00:00"
        textField.isUserInteractionEnabled = false
        // 커서 색상 없애기
        textField.tintColor = UIColor.clear
        return textField
    }()
    // 스케줄 상단 라인 설정
    let scheduleTopBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayLightForBorder
        return view
    }()
    // 제목 텍스트 필드 설정
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.text = "제목"
        textField.isUserInteractionEnabled = false
        return textField
    }()
    // 내용 텍스트 뷰 설정
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = ColorPalette.BlackForText
        textView.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textView.backgroundColor = ColorPalette.GrayForBackground
        textView.layer.cornerRadius = 5
        textView.isEditable = false
        textView.text = "내용"
        textView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]
        return textView
    }()
    // 장소 라벨 설정
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "장소"
        label.textColor = ColorPalette.GrayForText
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        return label
    }()
    // 장소 텍스트 필드 설정
    let locationTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        textField.textAlignment = .right
        textField.text = "장소"
        textField.isUserInteractionEnabled = false
        return textField
    }()
    // 카테고리 라벨 설정
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.textColor = ColorPalette.GrayForText
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        return label
    }()
    // 카테고리 텍스트 필드 설정
    let categoryTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        textField.textAlignment = .right
        textField.text = "카테고리"
        textField.isUserInteractionEnabled = false
        return textField
    }()
    // 좋아요 버튼 설정
    let likeButton: UIButton = {
        let button = UIButton()
        button.setTitle("0", for: .normal)
        button.setTitleColor(ColorPalette.BlackForText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        button.setImage(UIImage(named: "ic_like_default"), for: .normal)
        button.setImage(UIImage(named: "ic_like_selected"), for: .selected)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(pushLikeButton), for: .touchUpInside)
        return button
    }()
    // 댓글 버튼 설정
    let commentButton: UIButton = {
        let button = UIButton()
        button.setTitle("0", for: .normal)
        button.setTitleColor(ColorPalette.BlackForText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        button.setImage(UIImage(named: "ic_comment"), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    // 스케줄 하단 라인 설정
    let scheduleBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayLightForBorder
        return view
    }()
    // 기본 사용자 프로필 이미지 설정
    let profileImageView: UIImageView = UIImageView(image: UIImage(named: "ic_profile_default"))
    // 기본 사용자 닉네임 설정
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임(나)"
        label.textColor = ColorPalette.BlackForText
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    // 댓글 텍스트 필드 설정
    let commentTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "댓글을 입력하세요.", attributes: [NSAttributedStringKey.foregroundColor: ColorPalette.GrayForText])
        textField.textColor = ColorPalette.BlackForText
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textField.tag = 1000
        return textField
    }()
    // 댓글 입력 버튼 설정
    let commentAddButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_comment_add"), for: .normal)
        return button
    }()
    // 댓글 텍스트 필드 하단 라인 설정
    let commentBottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 댓글 테이블 뷰 설정
    let commentTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
}

extension ScheduleDetailView: ScheduleDetailViewProtocol {
    @objc func pushLikeButton() {
        self.likeButton.isSelected = self.likeButton.isSelected == true ? false : true
    }
    
    @objc func pushEdit() {
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
        // 스케줄 이미지 뷰 추가
        self.centerView.addSubview(self.scheduleImageView)
        self.scheduleImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.size.height.equalTo(350)
        }
        // 시작일 라벨 추가
        self.centerView.addSubview(self.startDateLabel)
        self.startDateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.scheduleImageView.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.width.equalTo(80)
        }
        // 시작일 텍스트 필드 추가
        self.centerView.addSubview(self.startDateTextField)
        self.startDateTextField.snp.makeConstraints { make in
            make.top.equalTo(self.scheduleImageView.snp.bottom).offset(18)
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
        self.centerView.addSubview(self.endDateTextField)
        self.endDateTextField.snp.makeConstraints { make in
            make.top.equalTo(self.startDateTextField.snp.bottom).offset(10)
            make.left.equalTo(self.endDateLabel.snp.right)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 스케줄 상단 라인 추가
        self.centerView.addSubview(self.scheduleTopBorderView)
        self.scheduleTopBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.endDateLabel.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(7)
        }
        // 제목 텍스트 필드 추가
        self.centerView.addSubview(self.titleTextField)
        self.titleTextField.snp.makeConstraints { make in
            make.top.equalTo(self.scheduleTopBorderView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 내용 텍스트 뷰 추가
        self.centerView.addSubview(self.contentTextView)
        self.contentTextView.snp.makeConstraints { make in
            make.top.equalTo(self.titleTextField.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.height.equalTo(100)
        }
        // 장소 라벨 추가
        self.centerView.addSubview(self.locationLabel)
        self.locationLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentTextView.snp.bottom).offset(19)
            make.left.equalToSuperview().offset(offsetLeftValue)
        }
        // 장소 텍스트 필드 추가
        self.centerView.addSubview(self.locationTextField)
        self.locationTextField.snp.makeConstraints { make in
            make.centerY.equalTo(self.locationLabel)
            make.left.equalTo(self.locationLabel.snp.right).offset(0)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 카테고리 라벨 추가
        self.centerView.addSubview(self.categoryLabel)
        self.categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(self.locationLabel.snp.bottom).offset(19)
            make.left.equalToSuperview().offset(offsetLeftValue)
        }
        // 카테고리 텍스트 필드 추가
        self.centerView.addSubview(self.categoryTextField)
        self.categoryTextField.snp.makeConstraints { make in
            make.centerY.equalTo(self.categoryLabel)
            make.left.equalTo(self.categoryLabel.snp.right).offset(0)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 좋아요 버튼 추가
        self.centerView.addSubview(self.likeButton)
        self.likeButton.snp.makeConstraints { make in
            make.top.equalTo(self.categoryTextField).offset(29)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        // 댓글 버튼 추가
        self.centerView.addSubview(self.commentButton)
        self.commentButton.snp.makeConstraints { make in
            make.top.equalTo(self.categoryTextField).offset(29)
            make.left.equalTo(self.likeButton.snp.right).offset(15)
            make.height.equalTo(30)
        }
        // 스케줄 하단 라인 추가
        self.centerView.addSubview(self.scheduleBottomBorderView)
        self.scheduleBottomBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.likeButton.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(7)
        }
        // 기본 사용자 프로필 이미지 설정
        self.centerView.addSubview(self.profileImageView)
        self.profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.scheduleBottomBorderView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(30)
        }
        // 기본 사용자 닉네임 설정
        self.centerView.addSubview(self.nicknameLabel)
        self.nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.profileImageView)
            make.left.equalTo(self.profileImageView.snp.right).offset(10)
        }
        // 댓글 입력 버튼 추가
        self.centerView.addSubview(self.commentAddButton)
        self.commentAddButton.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(offsetRightValue)
        }
        // 댓글 텍스트 필드 추가
        self.centerView.addSubview(self.commentTextField)
        self.commentTextField.snp.makeConstraints { make in
            //make.top.equalTo(self.profileImageView.snp.bottom).offset(20)
            make.centerY.equalTo(self.commentAddButton)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalTo(self.commentAddButton.snp.left).offset(5)
        }
        // 댓글 텍스트 하단 라인 추가
        self.centerView.addSubview(self.commentBottomBorderView)
        self.commentBottomBorderView.snp.makeConstraints { make in
            //make.top.equalTo(self.commentTextField.snp.bottom).offset(8)
            make.top.equalTo(self.commentAddButton.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(offsetLeftValue - 5)
            make.right.equalToSuperview().offset(offsetRightValue + 5)
            make.height.equalTo(1)
        }
        // 댓글 테이블 뷰 추가
        self.centerView.addSubview(self.commentTableView)
        self.commentTableView.snp.makeConstraints { make in
            make.top.equalTo(self.commentBottomBorderView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(offsetLeftValue)
            make.right.equalToSuperview().offset(offsetRightValue)
            make.bottom.equalToSuperview()
        }
    }
}
