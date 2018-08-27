//
//  LicenseView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class LicenseView: SuperViewController {
    var presenter: LicensePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.licenseTableView.delegate = self
        self.licenseTableView.dataSource = self
    }
    // 오픈 소스 라이브러리 라벨 설정
    let openSourceLibraryLabel: UILabel = {
        let label = UILabel()
        label.text = "Open Source Library"
        label.textColor = ColorPalette.BlackForText
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    // 오픈 소스 라이브러리 하단 라인 설정
    let openSourceLibraryBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // MIT 라벨 설정
    let mitLabel: UILabel = {
        let label = UILabel()
        label.text = "MIT License"
        label.textColor = ColorPalette.BlackForText
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    // MIT 텍스트 뷰 설정
    let mitTextView: UITextView = {
        let textView = UITextView()
        textView.text = """
        Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
        
        The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
        
        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
        """
        textView.textColor = ColorPalette.GrayForText
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        textView.layer.borderColor = ColorPalette.GrayForBottomBorder.cgColor
        textView.layer.borderWidth = 1
        textView.isEditable = false
        return textView
    }()
    // MIT 하단 라인 설정
    let mitBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 라이선스 테이블뷰 설정
    let licenseTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
}

extension LicenseView: LicenseViewProtocol {
    func initializeUI() {
        self.view.backgroundColor = .white
        // 오픈 소스 라이브러리 라벨 추가
        self.view.addSubview(self.openSourceLibraryLabel)
        self.openSourceLibraryLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(18)
            make.left.equalToSuperview().offset(8)
        }
        // 오픈 소스 라이브러리 하단 라인 추가
        self.view.addSubview(self.openSourceLibraryBorderView)
        self.openSourceLibraryBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.openSourceLibraryLabel.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.size.height.equalTo(1)
        }
        // MIT 라벨 추가
        self.view.addSubview(self.mitLabel)
        self.mitLabel.snp.makeConstraints { make in
            make.top.equalTo(self.openSourceLibraryBorderView.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(8)
        }
        // MIT 텍스트 뷰 추가
        self.view.addSubview(self.mitTextView)
        self.mitTextView.snp.makeConstraints { make in
            make.top.equalTo(self.mitLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(120)
        }
        // MIT 하단 라인 추가
        self.view.addSubview(self.mitBorderView)
        self.mitBorderView.snp.makeConstraints { make in
            make.top.equalTo(self.mitTextView.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.size.height.equalTo(1)
        }
        // 라이선스 테이블뷰 추가
        self.view.addSubview(self.licenseTableView)
        self.licenseTableView.snp.makeConstraints { make in
            make.top.equalTo(self.mitBorderView.snp.bottom)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }
}

extension LicenseView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? LicenseTableViewCell {
            if let url = URL(string: cell.urlLabel.text!) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LicenseTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "licenseCell")
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "SnapKit"
            cell.urlLabel.text = "https://github.com/SnapKit/SnapKit"
            cell.copyrightLabel.text = "Copyright (c) 2011-Present SnapKit Team"
            cell.licenseLabel.text = "MIT License"
        case 1:
            cell.titleLabel.text = "SwiftLint"
            cell.urlLabel.text = "https://github.com/realm/SwiftLint"
            cell.copyrightLabel.text = "Copyright (c) 2015 Realm Inc."
            cell.licenseLabel.text = "The MIT License (MIT)"
        case 2:
            cell.titleLabel.text = "FSCalendar"
            cell.urlLabel.text = "https://github.com/WenchaoD/FSCalendar"
            cell.copyrightLabel.text = "Copyright (c) 2013-2016 FSCalendar"
            cell.licenseLabel.text = "MIT License"
        case 3:
            cell.titleLabel.text = "Alamofire"
            cell.urlLabel.text = "https://github.com/Alamofire/Alamofire"
            cell.copyrightLabel.text = "Copyright (c) 2014-2018 Alamofire Software Foundation"
            cell.licenseLabel.text = "MIT License"
        case 4:
            cell.titleLabel.text = "AlamofireImage"
            cell.urlLabel.text = "https://github.com/Alamofire/AlamofireImage"
            cell.copyrightLabel.text = "Copyright (c) 2015-2018 Alamofire Software Foundation"
            cell.licenseLabel.text = "MIT License"
        case 5:
            cell.titleLabel.text = "AlamofireNetworkActivityIndicator"
            cell.urlLabel.text = "https://github.com/Alamofire/AlamofireNetworkActivityIndicator"
            cell.copyrightLabel.text = "Copyright (c) 2015 Tristan Himmelman"
            cell.licenseLabel.text = "The MIT License (MIT)"
        case 6:
            cell.titleLabel.text = "AlamofireObjectMapper"
            cell.urlLabel.text = "https://github.com/tristanhimmelman/AlamofireObjectMapper"
            cell.copyrightLabel.text = "Copyright (c) 2016 Alamofire Software Foundation"
            cell.licenseLabel.text = "MIT License"
        case 7:
            cell.titleLabel.text = "SVProgressHUD"
            cell.urlLabel.text = "https://github.com/SVProgressHUD/SVProgressHUD"
            cell.copyrightLabel.text = "Copyright (c) 2011-2018 Sam Vermette, Tobias Tiemerding and contributors."
            cell.licenseLabel.text = "MIT License"
        default:
            ()
        }
        return cell
    }
}
