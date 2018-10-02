//
//  ScheduleDetailPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import SVProgressHUD

class ScheduleDetailPresenter: ScheduleDetailPresenterProtocol {
    var view: ScheduleDetailViewProtocol?
    var interactor: ScheduleDetailInteractorInputProtocol?
    var wireframe: ScheduleDetailWireframeProtocol?
    
    func viewDidLoad() {
        view?.initializeUI()
    }
}

extension ScheduleDetailPresenter: ScheduleDetailInteractorOutputProtocol {
    func didRetrieveScheduleDetail(_ feedList: [Feed]) {
        ()
    }
    
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
