//
//  MainPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 30..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class MainPresenter: MainPresenterProtocol {
    var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    var wireFrame: MainWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showHUD(with: "일정 및 피드를 불러오는중입니다.")
        interactor?.retrieveScheduleAndFeedList(0)
        view?.initializeUI()
    }
    
    func pushUserInfo() {
        //
    }
    
    func pushNotification() {
        //
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    func didRetrieveScheduleAndFeedList(_ scheduleList: [Schedule], _ feedList: [Feed]) {
        view?.scheduleList = scheduleList
        view?.feedList = feedList
        view?.reloadMainData()
        view?.dismissHUD()
    }
    
    func onError(_ message: String) {
        view?.showError(with: message)
    }
}
