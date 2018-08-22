//
//  LicensePresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import SVProgressHUD

class LicensePresenter: LicensePresenterProtocol {
    var view: LicenseViewProtocol?
    var interactor: LicenseInteractorInputProtocol?
    var wireframe: LicenseWireframeProtocol?
    
    func viewDidLoad() {
        view?.initializeUI()
    }
}

extension LicensePresenter: LicenseInteractorOutputProtocol {
    
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
