//
//  ScheduleListView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class ScheduleListView: SuperViewController {
    var presenter: ScheduleListPresenterProtocol?
    var dateValue: String?
    var feedList: [Feed]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
        //내비게이션바 설정
        let titleImageView = UIImageView(image: UIImage(named: "title_navigation"))
        self.navigationItem.titleView = titleImageView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let scheduleDate = self.dateValue {
            self.presenter?.viewWillAppear(scheduleDate)
        }
    }
    
    // 피드 설정
    let feedTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    // 스케줄 추가 버튼 설정
    let addScheduleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_plus"), for: .normal)
        button.addTarget(self, action: #selector(pushAddSchedule), for: .touchUpInside)
        return button
    }()
}

extension ScheduleListView: ScheduleListViewProtocol {
    @objc func pushAddSchedule() {
        if let dateValue = self.dateValue {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            let date = formatter.date(from: dateValue)!
            formatter.dateFormat = "yyyy"
            let selectedYearIndex = Int(formatter.string(from: date))! - 2018
            formatter.dateFormat = "MM"
            let selectedMonthIndex = Int(formatter.string(from: date))! - 1
            formatter.dateFormat = "dd"
            let selectedDayIndex = Int(formatter.string(from: date))! - 1
            formatter.dateFormat = "yyyy.MM.dd HH:mm"
            let selectedDate = formatter.string(from: date)
            self.presenter?.presentScheduleForAdd(with: selectedDate, selectedYearIndex, selectedMonthIndex, selectedDayIndex)
        } else {
            SVProgressHUD.showError(withStatus: "스케줄을 추가 할 수 없습니다.")
        }
    }
    
    func reloadFeed() {
        self.feedTableView.reloadData()
    }
    
    func initializeUI() {
        self.view.addSubview(self.feedTableView)
        self.feedTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin).offset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin).offset(-20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin).offset(-20)
        }
        self.view.addSubview(self.addScheduleButton)
        self.addScheduleButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

extension ScheduleListView: UITableViewDelegate, UITableViewDataSource {
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
            if feedList.count == indexPath.row + 1, let scheduleDate = self.dateValue {
                self.presenter?.detectEndOfScroll(feedList.count, scheduleDate)
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
            if let scheduleImageUrl = feed.scheduleImageUrl {
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
                likeImage.image = UIImage(named: "ic_like_selected")
            } else {
                likeImage.image = UIImage(named: "ic_like_default")
            }
            likeCountAttributedString.append(NSAttributedString(attachment: likeImage))
            likeCountAttributedString.append(NSAttributedString(string: String(feed.likeCount)))
            cell.likeLabel.attributedText = likeCountAttributedString
            // 댓글 숫자 설정
            let commentCountAttributedString = NSMutableAttributedString(string: "")
            let commentImage = NSTextAttachment()
            commentImage.image = UIImage(named: "ic_comment")
            commentCountAttributedString.append(NSAttributedString(attachment: commentImage))
            commentCountAttributedString.append(NSAttributedString(string: String(feed.commentCount)))
            cell.commentLabel.attributedText = commentCountAttributedString
            // 비공개 여부 설정
            let endDatetimeTextAttributedString = NSMutableAttributedString(string: "")
            if feed.isPublic == "N" {
                let privateImage = NSTextAttachment()
                privateImage.image = UIImage(named: "ic_private")
                endDatetimeTextAttributedString.append(NSAttributedString(attachment: privateImage))
            }
            endDatetimeTextAttributedString.append(NSAttributedString(string: feed.endDatetimeText))
            cell.endDatetimeTextLabel.attributedText = endDatetimeTextAttributedString
        }
        return cell
    }
}
