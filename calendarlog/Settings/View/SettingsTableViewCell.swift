//
//  SettingsTableViewCell.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 23..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    // 제목 설정
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "타이틀"
        label.textColor = ColorPalette.BlackForText
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    // 내용 설정
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = ">"
        label.textColor = ColorPalette.GrayForText
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    // 하단 라인 설정
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 제목 추가
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
        }
        // 내용 추가
        self.contentView.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.titleLabel)
            make.right.equalToSuperview().offset(-18)
        }
        // 하단 라인 추가
        self.contentView.addSubview(self.borderView)
        self.borderView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
