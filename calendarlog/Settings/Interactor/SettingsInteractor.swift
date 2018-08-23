//
//  SettingsInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Foundation

class SettingsInteractor: SettingsInteractorInputProtocol {
    var presenter: SettingsInteractorOutputProtocol?
    var remoteDatamanager: SettingsRemoteDataManagerInputProtocol?
    
    func updateNoteStatus(_ isReceiveNote: Bool) {
        let email = UserDefaults.standard.string(forKey: "email")!
        self.remoteDatamanager?.tryUpdateNoteStatus(email, isReceiveNote)
    }
    
    func turnOffAutoLogin() {
        UserDefaults.standard.set("", forKey: "email")
        UserDefaults.standard.set("", forKey: "password")
        UserDefaults.standard.set("", forKey: "nickname")
        UserDefaults.standard.set(false, forKey: "isAutoLogin")
        self.presenter?.presentLogin()
    }
    
    func deleteUserInfo() {
        let email = UserDefaults.standard.string(forKey: "email")!
        self.remoteDatamanager?.tryDeleteUserInfo(email)
    }
}

extension SettingsInteractor: SettingsRemoteDataManagerOutputProtocol {
    func onUpdateNoteStatus(_ isReceiveNote: Bool) {
        UserDefaults.standard.set(isReceiveNote, forKey: "isReceiveNote")
        self.presenter?.didUpdateNoteStatus(isReceiveNote)
    }
    
    func onDeleteUserInfoSuccess() {
        UserDefaults.standard.set("", forKey: "email")
        UserDefaults.standard.set("", forKey: "password")
        UserDefaults.standard.set("", forKey: "nickname")
        UserDefaults.standard.set(false, forKey: "isAutoLogin")
        self.presenter?.presentLogin()
    }
    
    func onError(_ message: String) {
        self.presenter?.onError(message)
    }
}
