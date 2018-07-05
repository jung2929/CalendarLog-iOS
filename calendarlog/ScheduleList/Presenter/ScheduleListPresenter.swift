//
//  ScheduleListPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import SVProgressHUD

class ScheduleListPresenter: ScheduleListPresenterProtocol {
    var view: ScheduleListViewProtocol?
    var interactor: ScheduleListInteractorInputProtocol?
    var wireframe: ScheduleListWireframeProtocol?
    
    func viewDidLoad() {
        view?.initializeUI()
    }
}

extension ScheduleListPresenter: ScheduleListInteractorOutputProtocol {
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
