//
//  MainTableViewCell.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 6. 1..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    let feedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 19
        return view
    }()
    let profileImageView: UIImageView = UIImageView(image: UIImage(named: "ic_profile_default.png"))
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textColor = ColorPalette.BlackForText
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    let commentDateTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2018-12-31 오후 5:00"
        label.textColor = ColorPalette.GrayForText
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "타이틀/타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀타이틀"
        label.textColor = ColorPalette.BlackForText
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "내용/내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용"
        label.textColor = ColorPalette.GrayForText
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 3
        return label
    }()
    let likeLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = ColorPalette.GrayForText
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
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
        // 이메일 텍스트 필드 하단 라인 설정
        let borderView: UIView = UIView()
        borderView.backgroundColor = ColorPalette.GrayForBottomBorder
        self.feedView.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(8)
            make.size.height.equalTo(1)
        }
        self.feedView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.bottom).offset(15)
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
