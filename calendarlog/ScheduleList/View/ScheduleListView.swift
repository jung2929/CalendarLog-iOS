//
//  ScheduleListView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit
import Alamofire

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
        let titleImageView = UIImageView(image: UIImage(named: "title_navigation.png"))
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
}

extension ScheduleListView: ScheduleListViewProtocol {
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
//            make.top.equalTo(self.fsCalendar.snp.bottom).offset(20)
//            make.left.right.equalToSuperview().inset(20)
//            make.bottom.equalToSuperview()
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
}
