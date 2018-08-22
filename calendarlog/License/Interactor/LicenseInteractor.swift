//
//  LicenseInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Foundation

class LicenseInteractor: LicenseInteractorInputProtocol {
    var presenter: LicenseInteractorOutputProtocol?
    var remoteDatamanager: LicenseRemoteDataManagerInputProtocol?
    
}

extension LicenseInteractor: LicenseRemoteDataManagerOutputProtocol {
    func onError(_ message: String) {
        presenter?.onError(message)
    }
}
