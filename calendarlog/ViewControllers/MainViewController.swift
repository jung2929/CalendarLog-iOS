//
//  MainViewController.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 23..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit
import FSCalendar

class MainViewController: SuperViewController, FSCalendarDataSource, FSCalendarDelegate {
    // 메인 스크롤 뷰 설정
    let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    // 메인 뷰 설정
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // 캘린더 설정
    fileprivate var fsCalendar: FSCalendar!
    override func viewDidAppear(_ animated: Bool) {
        self.initializeUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
        view.addSubview(self.mainScrollView)
        self.mainScrollView.snp.makeConstraints { view in
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            view.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
            view.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
            view.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        self.mainScrollView.addSubview(self.mainView)
        self.mainView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(20)
            view.left.right.equalTo(self.view).inset(20)
            view.bottom.equalToSuperview()
        }
    }
    @objc func pushUserInfo() {
        self.presentAlert(title: "사용자 계정정보", message: "클릭")
    }
    @objc func pushNotification() {
        self.presentAlert(title: "알람", message: "클릭")
    }
    func initializeUI() {
        let calendarSize = self.mainView.bounds.width
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: calendarSize, height: calendarSize))
        calendar.backgroundColor = .white
        calendar.layer.cornerRadius = 19
        calendar.clipsToBounds = true
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.dataSource = self
        calendar.delegate = self
        self.mainView.addSubview(calendar)
        self.fsCalendar = calendar
        let backBlueImageView = UIImageView(image: UIImage(named: "ic_back_blue.png"))
        let frontBlueImageView = UIImageView(image: UIImage(named: "ic_front_blue.png"))
        self.mainView.addSubview(backBlueImageView)
        backBlueImageView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(20)
            view.leading.equalToSuperview().inset(20)
        }
        self.mainView.addSubview(frontBlueImageView)
        frontBlueImageView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(20)
            view.trailing.equalToSuperview().inset(20)
        }
        let label1 = UILabel()
        label1.numberOfLines = 0
        label1.text = "1sdlkfaaaaaaasaasdas\nlksjdf\nlksjd\nflksdjf\nlkd\njfdslkjf\nkldsjf\nlksdj\nfklsdj"
        label1.textColor = .black
        label1.backgroundColor = .blue
        self.mainView.addSubview(label1)
        label1.snp.makeConstraints { view in
            view.top.equalTo(self.fsCalendar.snp.bottom).offset(100)
            view.left.equalToSuperview().offset(20)
            view.right.equalToSuperview().offset(-20)
        }
        let label2 = UILabel()
        label2.numberOfLines = 0
        label2.text = "2sdlkf\nlksjdf\nlksjd\nflksdjf\nlkd\njfdslkjf\nkldsjf\nlksdj\nfklsdj"
        label2.textColor = .black
        label2.backgroundColor = .red
        self.mainView.addSubview(label2)
        label2.snp.makeConstraints { view in
            view.top.equalTo(label1.snp.bottom).offset(100)
            view.left.equalToSuperview().offset(20)
            view.right.equalToSuperview().offset(-20)
        }
        let label3 = UILabel()
        label3.numberOfLines = 0
        label3.text = "3sdlkf\nlksjdf\nlksjd\nflksdjf\nlkd\njfdslkjf\nkldsjf\nlksdj\nfklsdj"
        label3.textColor = .black
        label3.backgroundColor = .brown
        self.mainView.addSubview(label3)
        label3.snp.makeConstraints { view in
            view.top.equalTo(label2.snp.bottom).offset(20)
            view.left.equalToSuperview().offset(20)
            view.right.equalToSuperview().offset(-20)
            view.bottom.equalToSuperview().offset(-20)
        }
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
}
