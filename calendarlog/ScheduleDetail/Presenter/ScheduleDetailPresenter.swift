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
        self.view?.initializeUI()
    }
    
    func viewWillAppear() {
        SVProgressHUD.show(withStatus: "일정 및 댓글내역을 불러오는중입니다.")
        self.view?.loadScheduleDetail()
        SVProgressHUD.dismiss()
        //self.interactor?.retrieveScheduleDetail((view?.sequence)!)
    }
    
    func presentScheduleForEdit() {
        ()
    }
}

extension ScheduleDetailPresenter: ScheduleDetailInteractorOutputProtocol {
    func didRetrieveScheduleDetail(_ feedList: [Feed]) {
        //self.view?.loadScheduleDetail()
    }
    
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
