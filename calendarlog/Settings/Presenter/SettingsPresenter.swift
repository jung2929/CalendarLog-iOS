//
//  SettingsPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import SVProgressHUD

class SettingsPresenter: SettingsPresenterProtocol {
    var view: SettingsViewProtocol?
    var interactor: SettingsInteractorInputProtocol?
    var wireframe: SettingsWireframeProtocol?
    
    func viewDidLoad() {
        self.view?.initializeUI()
    }
    
    func updateNoteStatus(_ isReceiveNote: Bool) {
        self.interactor?.updateNoteStatus(isReceiveNote)
    }
    
    func presentLicense() {
        self.wireframe?.presentLicense(from: self.view!)
    }
    
    func turnOffAutoLogin() {
        self.interactor?.turnOffAutoLogin()
    }
    
    func deleteUserInfo() {
        self.interactor?.deleteUserInfo()
    }
}

extension SettingsPresenter: SettingsInteractorOutputProtocol {
    func didUpdateNoteStatus(_ isReceiveNote: Bool) {
        self.view?.switchNoteStatus(isReceiveNote)
    }
    
    func presentLogin() {
        self.wireframe?.presentLogin(from: self.view!)
    }
    
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
