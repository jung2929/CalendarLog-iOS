//
//  FeedTableViewCell.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 6. 1..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    var feed: Feed?
    // 피드 뷰 설정
    let feedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 19
        return view
    }()
    // 기본 사용자 프로필 이미지 설정
    let profileImageView: UIImageView = UIImageView(image: UIImage(named: "ic_profile_default"))
    // 기본 사용자 닉네임 설정
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textColor = ColorPalette.BlackForText
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    // 등록시간 설정
    let commentDateTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2018-12-31 PM 5:00"
        label.textColor = ColorPalette.GrayForText
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    // 이메일 텍스트 필드 하단 라인 설정
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 이미지뷰 설정
    let scheduleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_placeholder")
        return imageView
    }()
    // 제목 설정
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "타이틀"
        label.textColor = ColorPalette.BlackForText
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    // 내용 설정
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.textColor = ColorPalette.GrayForText
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 3
        return label
    }()
    // 좋아요 수, 아이콘 설정
    let likeLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = ColorPalette.GrayForText
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    // 댓글 수, 아이콘 설정
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = ColorPalette.GrayForText
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(self.feedView)
        self.feedView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            //make.height.equalTo(191)
        }
        self.feedView.addSubview(self.profileImageView)
        self.profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(30)
        }
        self.feedView.addSubview(self.nicknameLabel)
        self.nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.profileImageView)
            make.left.equalTo(self.profileImageView.snp.right).offset(10)
        }
        self.feedView.addSubview(self.commentDateTimeLabel)
        self.commentDateTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.profileImageView)
            make.right.equalToSuperview().offset(-10)
        }
        self.feedView.addSubview(self.borderView)
        self.borderView.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(8)
            make.size.height.equalTo(1)
        }
        self.feedView.addSubview(self.scheduleImageView)
        self.scheduleImageView.snp.makeConstraints { make in
            make.top.equalTo(self.borderView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.size.height.equalTo(200)
        }
        self.feedView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.scheduleImageView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        self.feedView.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        self.feedView.addSubview(self.likeLabel)
        self.likeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-18)
        }
        self.feedView.addSubview(self.commentLabel)
        self.commentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentLabel.snp.bottom).offset(20)
            make.left.equalTo(self.likeLabel.snp.right).offset(15)
            make.bottom.equalToSuperview().offset(-18)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
