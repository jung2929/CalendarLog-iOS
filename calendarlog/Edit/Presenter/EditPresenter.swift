//
//  EditPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import SVProgressHUD

class EditPresenter: EditPresenterProtocol {
    var view: EditViewProtocol?
    var interactor: EditInteractorInputProtocol?
    var wireframe: EditWireframeProtocol?
    
    func viewDidLoad() {
        view?.initializeUI()
    }
}

extension EditPresenter: EditInteractorOutputProtocol {
    
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
