//
//  UserInfoPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import SVProgressHUD

class UserInfoPresenter: UserInfoPresenterProtocol {
    var view: UserInfoViewProtocol?
    var interactor: UserInfoInteractorInputProtocol?
    var wireframe: UserInfoWireframeProtocol?
    
    func viewDidLoad() {
        view?.initializeUI()
    }
}

extension UserInfoPresenter: UserInfoInteractorOutputProtocol {
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
