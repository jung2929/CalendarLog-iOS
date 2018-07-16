//
//  MainView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 28..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit
import FSCalendar
import Alamofire
import AlamofireImage

class MainView: SuperViewController {
    var presenter: MainPresenterProtocol?
    var scheduleList: [Schedule]?
    var feedList: [Feed]?
    
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
        self.presenter?.viewDidLoad()
        self.fsCalendar.delegate = self
        self.fsCalendar.dataSource = self
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
        //내비게이션바 설정
        let titleImageView = UIImageView(image: UIImage(named: "title_navigation.png"))
        self.navigationItem.titleView = titleImageView
        // 내비게이션바 좌측상단 사람 이미지 설정
        let profileButton = UIButton.init(type: .custom)
        profileButton.setImage(UIImage.init(named: "ic_profile_main.png"), for: .normal)
        profileButton.addTarget(self, action: #selector(self.pushUserInfo), for: .touchUpInside)
        let profileBarButtonImte = UIBarButtonItem.init(customView: profileButton)
        self.navigationItem.leftBarButtonItem = profileBarButtonImte
        // 내비게이션바 우측상단 쪽지 이미지 설정
        let noteBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_note.png"), style: .done, target: self, action: #selector(self.pushNoteList))
        self.navigationItem.rightBarButtonItem = noteBarButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter?.viewWillAppear()
    }
    
    // 캘린더 설정
    fileprivate var fsCalendar: FSCalendar!
    
    // 피드 설정
    let feedTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
}
extension MainView: MainViewProtocol {
    func reloadMainData() {
        self.fsCalendar.reloadData()
        self.feedTableView.reloadData()
    }
    
    @objc func pushUserInfo() {
        self.presenter?.presentUserInfo()
    }
    
    @objc func pushNoteList() {
        self.presenter?.presentNoteList()
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
        // 캘린더 설정
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
        self.feedTableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.view.addSubview(self.feedTableView)
        self.feedTableView.snp.makeConstraints { make in
            make.top.equalTo(self.fsCalendar.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}

extension MainView: FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let feedList = self.feedList {
            return feedList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell: FeedTableViewCell = tableView.cellForRow(at: indexPath) as? FeedTableViewCell {
            if let feed = cell.feed {
                self.presenter?.presentScheduleDetail(with: feed)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let feedList = self.feedList {
            if feedList.count == indexPath.row + 1 {
                self.presenter?.detectEndOfScroll(feedList.count)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FeedTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "feedCell")
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        if let feedList = self.feedList {
            let feed = feedList[indexPath.row]
            // Feed 내용 설정
            cell.feed = feed
            // 닉네임 설정
            cell.nicknameLabel.text = feed.nickname
            // 일정 이미지 설정
            if let scheduleImageUrl = feed.url {
                Alamofire.request(scheduleImageUrl).responseImage { response in
                    if let image = response.result.value {
                        cell.scheduleImageView.image = image
                    }
                }
            } else {
                cell.scheduleImageView.snp.makeConstraints { make in
                    make.top.equalTo(cell.borderView.snp.bottom).offset(0)
                    make.size.equalTo(0)
                }
            }
            // 제목 설정
            cell.titleLabel.text = feed.title
            // 내용 설정
            cell.contentLabel.text = feed.content
            // 좋아요 숫자, 여부 설정
            let likeCountAttributedString = NSMutableAttributedString(string: "")
            let likeImage = NSTextAttachment()
            if feed.isLike == "Y" {
                likeImage.image = UIImage(named: "ic_like_selected.png")
            } else {
                likeImage.image = UIImage(named: "ic_like_default.png")
            }
            likeCountAttributedString.append(NSAttributedString(attachment: likeImage))
            likeCountAttributedString.append(NSAttributedString(string: String(feed.likeCount)))
            cell.likeLabel.attributedText = likeCountAttributedString
            // 댓글 숫자 설정
            let commentCountAttributedString = NSMutableAttributedString(string: "")
            let commentImage = NSTextAttachment()
            commentImage.image = UIImage(named: "ic_comment.png")
            commentCountAttributedString.append(NSAttributedString(attachment: commentImage))
            commentCountAttributedString.append(NSAttributedString(string: String(feed.commentCount)))
            cell.commentLabel.attributedText = commentCountAttributedString
            // 비공개 여부 설정
            let registerDatetimeAttributedString = NSMutableAttributedString(string: "")
            if feed.isPublic == "Y" {
                let privateImage = NSTextAttachment()
                privateImage.image = UIImage(named: "ic_private.png")
                registerDatetimeAttributedString.append(NSAttributedString(attachment: privateImage))
            }
            registerDatetimeAttributedString.append(NSAttributedString(string: feed.registerDatetime))
            cell.commentDateTimeLabel.attributedText = registerDatetimeAttributedString
        }
        return cell
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.feedTableView.contentOffset.y <= -self.feedTableView.contentInset.top
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
        if let scheduleList = self.scheduleList {
            for schedule in scheduleList {
                if schedule.scheduleDate == self.dateFormatter.string(from: date) {
                    return self.setScheduleUIImage(viewHeight: self.view.bounds.height, schedule.scheduleCount)
                }
            }
        }
        return nil
    }
    
    func setScheduleUIImage(viewHeight height: CGFloat, _ scheduleCount: Int) -> UIImage? {
        // SE -> 40 to 39 / 568.0
        // 8 -> 43 / 667.0
        // 8+ -> 43 / 736.0
        // X -> 43 / 812.0
        // iPad -> 43 / 1024.0
        if height < 600 {
            switch scheduleCount {
            case 1:
                return UIImage(named: "ic_schedule_39_1.png")!
            case 2:
                return UIImage(named: "ic_schedule_39_2.png")!
            case 3:
                return UIImage(named: "ic_schedule_39_3.png")!
            case 4:
                return UIImage(named: "ic_schedule_39_etc.png")!
            default:
                return nil
            }
        } else {
            switch scheduleCount {
            case 1:
                return UIImage(named: "ic_schedule_43_1.png")!
            case 2:
                return UIImage(named: "ic_schedule_43_2.png")!
            case 3:
                return UIImage(named: "ic_schedule_43_3.png")!
            case 4:
                return UIImage(named: "ic_schedule_43_etc.png")!
            default:
                return nil
            }
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
        }
        if let scheduleList = self.scheduleList {
            for schedule in scheduleList {
                if schedule.scheduleDate == self.dateFormatter.string(from: date) {
                    self.presenter?.presentScheduleList(with: self.dateFormatter.string(from: date))
                    return
                }
            }
        }
        self.presenter?.presentScheduleForAdd(with: self.dateFormatter.string(from: date))
    }
}
