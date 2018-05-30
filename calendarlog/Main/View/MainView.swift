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
        let calendar = FSCalendar(frame: CGRect(x: 20, y: 84, width: calendarSize, height: calendarSize))
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
        //calendar.dataSource = self
        calendar.delegate = self
        self.view.addSubview(calendar)
        self.fsCalendar = calendar
        let backBlueImageView = UIImageView(image: UIImage(named: "ic_back_blue.png"))
        let frontBlueImageView = UIImageView(image: UIImage(named: "ic_front_blue.png"))
        self.fsCalendar.addSubview(backBlueImageView)
        backBlueImageView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(15)
            view.leading.equalToSuperview().inset(15)
        }
        self.fsCalendar.addSubview(frontBlueImageView)
        frontBlueImageView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(15)
            view.trailing.equalToSuperview().inset(15)
        }
        self.view.addGestureRecognizer(self.scopeGesture)
    }
    
    func showError(with message: String) {
        presentAlert(title: "오류", message: message)
    }
}

extension MainView: FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        //let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        //if shouldBegin {
        if true {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.fsCalendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return true
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
    }
}
