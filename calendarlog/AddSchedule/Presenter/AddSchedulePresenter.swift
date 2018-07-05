//
//  AddSchedulePresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import SVProgressHUD

class AddSchedulePresenter: AddSchedulePresenterProtocol {
    var view: AddScheduleViewProtocol?
    var interactor: AddScheduleInteractorInputProtocol?
    var wireframe: AddScheduleWireframeProtocol?
    
    func viewDidLoad() {
        view?.initializeUI()
    }
}

extension AddSchedulePresenter: AddScheduleInteractorOutputProtocol {
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
