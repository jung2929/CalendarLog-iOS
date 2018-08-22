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
        view?.initializeUI()
    }
}

extension SettingsPresenter: SettingsInteractorOutputProtocol {
    
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
