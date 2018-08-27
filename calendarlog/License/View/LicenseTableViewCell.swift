//
//  LicenseTableViewCell.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 27..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class LicenseTableViewCell: UITableViewCell {
    // 제목 설정
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "타이틀"
        label.textColor = ColorPalette.BlackForText
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    // URL 설정
    let urlLabel: UILabel = {
        let label = UILabel()
        label.text = "URL"
        label.textColor = ColorPalette.BlueForText
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    // 저작권자 설정
    let copyrightLabel: UILabel = {
        let label = UILabel()
        label.text = "저작권자"
        label.textColor = ColorPalette.GrayForText
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    // 라이선스 설정
    let licenseLabel: UILabel = {
        let label = UILabel()
        label.text = "라이선스"
        label.textColor = ColorPalette.GrayForText
        label.font = .systemFont(ofSize: 12, weight: .medium)
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
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        // URL 추가
        self.contentView.addSubview(self.urlLabel)
        self.urlLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        // 저작권자 추가
        self.contentView.addSubview(self.copyrightLabel)
        self.copyrightLabel.snp.makeConstraints { make in
            make.top.equalTo(self.urlLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        // 라이선스 추가
        self.contentView.addSubview(self.licenseLabel)
        self.licenseLabel.snp.makeConstraints { make in
            make.top.equalTo(self.copyrightLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        // 하단 라인 추가
        self.contentView.addSubview(self.borderView)
        self.borderView.snp.makeConstraints { make in
            make.top.equalTo(self.licenseLabel.snp.bottom).offset(8)
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
