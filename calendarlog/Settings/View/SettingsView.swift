//
//  SettingsView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class SettingsView: SuperViewController {
    var presenter: SettingsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.isReceiveNoteSwitch.addTarget(self, action: #selector(self.pushNoteSwitch), for: .valueChanged)
        self.settingsTableView.delegate = self
        self.settingsTableView.dataSource = self
    }
    // 쪽지 수신 여부 라벨 설정
    let isReceiveNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "쪽지 수신"
        label.textColor = ColorPalette.BlackForText
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    // 쪽지 수신 여부 스위치 설정
    let isReceiveNoteSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.onTintColor = ColorPalette.Orange
        uiSwitch.isOn = UserDefaults.standard.bool(forKey: "isReceiveNote")
        return uiSwitch
    }()
    // 쪽지 수신 여부 하단 라인 설정
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.GrayForBottomBorder
        return view
    }()
    // 설정 테이블뷰 설정
    let settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
}

extension SettingsView: SettingsViewProtocol {
    func switchNoteStatus(_ isReceiveNote: Bool) {
        self.isReceiveNoteSwitch.isOn = isReceiveNote
    }
    
    @objc func pushNoteSwitch() {
        self.presenter?.updateNoteStatus(self.isReceiveNoteSwitch.isOn)
    }
    
    func pushLicense() {
        self.presenter?.presentLicense()
    }
    
    func pushLogOut() {
        let actionLogOut = UIAlertAction(title: "확인", style: .destructive) { _ in
            self.presenter?.turnOffAutoLogin()
        }
        self.presentAlertWithAction(title: "로그아웃", message: "로그아웃하시겠습니까?", actionLogOut)
    }
    
    func pushDeleteUserInfo() {
        let actionDeleteUserInfo = UIAlertAction(title: "탈퇴", style: .destructive) { _ in
            self.presenter?.deleteUserInfo()
        }
        self.presentAlertWithAction(title: "회원탈퇴", message: "회원탈퇴하시겠습니까?", actionDeleteUserInfo)
    }
    
    func initializeUI() {
        self.view.backgroundColor = .white
        // 쪽지 수신 여부 라벨 추가
        self.view.addSubview(self.isReceiveNoteLabel)
        self.isReceiveNoteLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(18)
            make.left.equalToSuperview().offset(18)
        }
        // 쪽지 수신 여부 스위치 추가
        self.view.addSubview(self.isReceiveNoteSwitch)
        self.isReceiveNoteSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(self.isReceiveNoteLabel)
            make.right.equalToSuperview().offset(-18)
        }
        // 쪽지 수신 여부 하단 라인 추가
        self.view.addSubview(self.borderView)
        self.borderView.snp.makeConstraints { make in
            make.top.equalTo(self.isReceiveNoteLabel.snp.bottom).offset(18)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.size.height.equalTo(1)
        }
        // 설정 테이블뷰 추가
        self.view.addSubview(self.settingsTableView)
        self.settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(self.borderView.snp.bottom)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }
}

extension SettingsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.pushLicense()
        case 1:
            self.pushLogOut()
        case 2:
            self.pushDeleteUserInfo()
        case 3:
            ()
        default:
            ()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingsTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "settingsCell")
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Open Source Library"
        case 1:
            cell.titleLabel.text = "로그아웃"
        case 2:
            cell.titleLabel.text = "회원탈퇴"
            cell.titleLabel.textColor = ColorPalette.RedForText
        case 3:
            cell.titleLabel.text = "앱 버전"
            cell.contentLabel.text = "1.0.0"
        default:
            ()
        }
        return cell
    }
}
