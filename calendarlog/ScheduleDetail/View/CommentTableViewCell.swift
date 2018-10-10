//
//  CommentTableViewCell.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 10. 10..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
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
    // 댓글 작성 시간 설정
    let registerDatetimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2018-12-31 오후 5:00"
        label.textColor = ColorPalette.GrayForText
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
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
        textView.isScrollEnabled = false
        return textView
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.profileImageView)
        self.profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(30)
        }
        self.contentView.addSubview(self.nicknameLabel)
        self.nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.profileImageView)
            make.left.equalTo(self.profileImageView.snp.right).offset(10)
        }
        self.contentView.addSubview(self.registerDatetimeLabel)
        self.registerDatetimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.profileImageView)
            make.right.equalToSuperview().offset(-20)
        }
        self.contentView.addSubview(self.contentTextView)
        self.contentTextView.snp.makeConstraints { make in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview()
            make.height.equalTo(35)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
