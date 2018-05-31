//
//  MainView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 28..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit
import FSCalendar

class MainView: SuperViewController {
    var presenter: MainPresenterProtocol?
    
    // 캘린더 설정
    fileprivate var fsCalendar: FSCalendar!
    
    // 피드 설정
    let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.fsCalendar, action: #selector(self.fsCalendar.handleScopeGesture))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.fsCalendar.delegate = self
        self.fsCalendar.dataSource = self
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        //내비게이션바 설정
        let titleImageView = UIImageView(image: UIImage(named: "title_navigation.png"))
        self.navigationItem.titleView = titleImageView
        // 내비게이션바 좌측상단 사람 이미지 설정
        let profileButton = UIButton.init(type: .custom)
        profileButton.setImage(UIImage.init(named: "ic_profile_main.png"), for: .normal)
        profileButton.addTarget(self, action: #selector(self.pushUserInfo), for: .touchUpInside)
        let profileBarButtonImte = UIBarButtonItem.init(customView: profileButton)
        self.navigationItem.leftBarButtonItem = profileBarButtonImte
        // 내비게이션바 우측상단 알람 이미지 설정
        let notificationBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_notification.png"), style: .done, target: self, action: #selector(self.pushNotification))
        self.navigationItem.rightBarButtonItem = notificationBarButtonItem
    }
}
extension MainView: MainViewProtocol {
    @objc func pushUserInfo() {
        self.presentAlert(title: "사용자 계정정보", message: "클릭")
    }
    
    @objc func pushNotification() {
        self.presentAlert(title: "알람", message: "클릭")
    }
    
    func initializeUI() {
        let calendarSize = self.view.bounds.width - 40
        let calendar = FSCalendar(frame: CGRect(x: 20, y: 94, width: calendarSize, height: calendarSize))
        calendar.backgroundColor = .white
        calendar.layer.cornerRadius = 19
        calendar.clipsToBounds = true
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.headerDateFormat = "M월 yyyy년"
        calendar.appearance.caseOptions = [.headerUsesUpperCase, .weekdayUsesSingleUpperCase]
        calendar.appearance.weekdayFont = .systemFont(ofSize: 12, weight: .medium)
        calendar.appearance.weekdayTextColor = ColorPalette.GrayForText
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 16, weight: .medium)
        calendar.appearance.headerTitleColor = ColorPalette.BlackForText
        calendar.appearance.titleFont = .systemFont(ofSize: 14, weight: .regular)
        calendar.appearance.subtitleFont = .systemFont(ofSize: 0, weight: .light)
        calendar.appearance.selectionColor = .clear
        calendar.appearance.todayColor = .clear
        calendar.appearance.todaySelectionColor = .clear
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.titleSelectionColor  = .black
        self.view.addSubview(calendar)
        self.fsCalendar = calendar
        let backBlueImageView = UIImageView(image: UIImage(named: "ic_back_blue.png"))
        let frontBlueImageView = UIImageView(image: UIImage(named: "ic_front_blue.png"))
        self.fsCalendar.addSubview(backBlueImageView)
        backBlueImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().inset(15)
        }
        self.fsCalendar.addSubview(frontBlueImageView)
        frontBlueImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
        }
        // 수직 드래그 제스쳐를 통해 캘린더 월/주 설정 변경
        self.view.addGestureRecognizer(self.scopeGesture)
        self.mainTableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.view.addSubview(self.mainTableView)
        self.mainTableView.snp.makeConstraints { make in
            make.top.equalTo(self.fsCalendar.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    func showError(with message: String) {
        presentAlert(title: "오류", message: message)
    }
}

extension MainView: FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentAlert(title: "알림", message: "\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "myIdentifier")
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        var attributedString = NSMutableAttributedString(string: "")
        var imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "ic_comment.png")
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: "12"))
        cell.commentLabel.attributedText = attributedString
        if indexPath.row == 0 {
            cell.nicknameLabel.text = "닉네임입니다"
            cell.titleLabel.text = "타이틀입니다"
            cell.contentLabel.text = "내용입니다"
            attributedString = NSMutableAttributedString(string: "")
            imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(named: "ic_like_selected")
            attributedString.append(NSAttributedString(attachment: imageAttachment))
            attributedString.append(NSAttributedString(string: "13"))
            cell.likeLabel.attributedText = attributedString
            //
            attributedString = NSMutableAttributedString(string: "")
            imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(named: "ic_private.png")
            attributedString.append(NSAttributedString(attachment: imageAttachment))
            attributedString.append(NSAttributedString(string: "2018-01-01 오후 4:00"))
            cell.commentDateTimeLabel.attributedText = attributedString
        } else {
            attributedString = NSMutableAttributedString(string: "")
            imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(named: "ic_like_default.png")
            attributedString.append(NSAttributedString(attachment: imageAttachment))
            attributedString.append(NSAttributedString(string: "12"))
            cell.likeLabel.attributedText = attributedString
        }
        return cell
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.mainTableView.contentOffset.y <= -self.mainTableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.fsCalendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        // SE -> 40 to 39 / 568.0
        // 8 -> 43 / 667.0
        // 8+ -> 43 / 736.0
        // X -> 43 / 812.0
        // iPad -> 43 / 1024.0
        let viewHeight = self.view.bounds.height
        if viewHeight < 600 {
            return UIImage(named: "oval40")
        } else {
            return UIImage(named: "oval43")
        }
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
            self.presentAlert(title: "알람", message: self.dateFormatter.string(from: date))
        }
        self.presentAlert(title: "알람", message: self.dateFormatter.string(from: date))
    }
}
