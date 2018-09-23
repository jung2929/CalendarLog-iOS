//
//  UserInfoView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit
import Alamofire

class UserInfoView: SuperViewController {
    var presenter: UserInfoPresenterProtocol?
    var userInfo: UserInfo?
    var feedList: [Feed]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
        // 내비게이션바 우측상단 설정 이미지 설정
        let settingsBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_settings"), style: .done, target: self, action: #selector(self.pushSettings))
        // 내비게이션바 우측상단 수정 이미지 설정
        let editBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_edit"), style: .done, target: self, action: #selector(self.pushEdit))
        self.navigationItem.rightBarButtonItems = [settingsBarButtonItem, editBarButtonItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
        let nickname = UserDefaults.standard.string(forKey: "nickname")
        self.nicknameLabel.text = nickname
    }
    
    // 기본 사용자 프로필 이미지 설정
    let profileImageView: UIImageView = UIImageView(image: UIImage(named: "ic_profile_user_info"))
    // 기본 사용자 닉네임 설정
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textColor = ColorPalette.White
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    // 좋아요 한 스케줄 라벨 설정
    let likedScheduleLabel: UILabel = {
        let label = UILabel()
        label.text = "좋아요 한 스케줄"
        label.textColor = ColorPalette.White
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    // 좋아요 한 스케줄 숫자 설정
    let likedScheduleCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = ColorPalette.White
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    // 피드 설정
    let feedTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
}

extension UserInfoView: UserInfoViewProtocol {
    func setLikedScheduleCount(_ count: String) {
        self.likedScheduleCountLabel.text = count
    }
    
    @objc func pushEdit() {
        self.presenter?.presentEdit()
    }
    
    @objc func pushSettings() {
        self.presenter?.presentSettings()
    }
    
    func reloadFeed() {
        self.feedTableView.reloadData()
    }
    
    func initializeUI() {
        // 윗 쪽 파랑배경 설정
        let backgroundTopimageView: UIImageView = UIImageView()
        if let backgroundTopImage = UIImage(named: "background_top") {
            backgroundTopimageView.image = backgroundTopImage
        }
        self.view.addSubview(backgroundTopimageView)
        backgroundTopimageView.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(self.view.frame.height / 2.5)
        }
        // 기본 사용자 프로필 이미지 추가
        self.view.addSubview(self.profileImageView)
        self.profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backgroundTopimageView)
            make.size.equalTo(60)
        }
        // 기본 사용자 닉네임 추가
        self.view.addSubview(self.nicknameLabel)
        self.nicknameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.profileImageView.snp.bottom).offset(10)
        }
        // 좋아요 한 스케줄 라벨 추가
        self.view.addSubview(self.likedScheduleLabel)
        self.likedScheduleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.nicknameLabel.snp.bottom).offset(15)
        }
        // 좋아요 한 스케줄 숫자 추가
        self.view.addSubview(self.likedScheduleCountLabel)
        self.likedScheduleCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.likedScheduleLabel)
            make.left.equalTo(self.likedScheduleLabel.snp.right).offset(5)
        }
        // 피드 추가
        self.view.addSubview(self.feedTableView)
        self.feedTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset((self.view.frame.height / 2.5) + 20)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin).offset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin).offset(-20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin).offset(-20)
        }
    }
}

extension UserInfoView: UITableViewDelegate, UITableViewDataSource {
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
            let registerDatetimeAttributedString = NSMutableAttributedString(string: "")
            if feed.isPublic == "N" {
                let privateImage = NSTextAttachment()
                privateImage.image = UIImage(named: "ic_private")
                registerDatetimeAttributedString.append(NSAttributedString(attachment: privateImage))
            }
            registerDatetimeAttributedString.append(NSAttributedString(string: feed.registerDatetime))
            cell.commentDateTimeLabel.attributedText = registerDatetimeAttributedString
        }
        return cell
    }
}
