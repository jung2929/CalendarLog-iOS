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
    
}

extension SettingsInteractor: SettingsRemoteDataManagerOutputProtocol {
    func onError(_ message: String) {
        presenter?.onError(message)
    }
}
