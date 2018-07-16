//
//  MainPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 30..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import SVProgressHUD

class MainPresenter: MainPresenterProtocol {
    var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    var wireframe: MainWireframeProtocol?
    
    func viewDidLoad() {
        self.view?.initializeUI()
    }
    
    func viewWillAppear() {
        SVProgressHUD.show(withStatus: "일정 및 피드를 불러오는중입니다.")
        self.interactor?.retrieveScheduleAndFeedList()
    }
    
    func detectEndOfScroll(_ row: Int) {
        SVProgressHUD.show(withStatus: "피드를 불러오는중입니다.")
        self.interactor?.retrieveFeedList(row)
    }
    
    func presentUserInfo() {
        self.wireframe?.presentUserInfo(from: self.view!)
    }
    
    func presentNoteList() {
        self.wireframe?.presentNoteList(from: self.view!)
    }
    
    func presentScheduleList(with date: String) {
        self.wireframe?.presentScheduleList(from: self.view!, with: date)
    }
    
    func presentScheduleDetail(with feed: Feed) {
        self.wireframe?.presentScheduleDetail(from: self.view!, with: feed)
    }
    
    func presentScheduleForAdd(with date: String) {
        self.wireframe?.presentScheduleForAdd(from: self.view!, with: date)
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    func didRetrieveScheduleAndFeedList(_ scheduleList: [Schedule], _ feedList: [Feed]) {
        self.view?.scheduleList = scheduleList
        self.view?.feedList = feedList
        self.view?.reloadMainData()
        SVProgressHUD.dismiss()
    }
    
    func didRetrieveFeedList(_ feedList: [Feed]) {
        if feedList.count != 0 {
            if self.view?.feedList == nil {
                self.view?.feedList = feedList
            } else {
                self.view?.feedList! += feedList
                self.view?.reloadMainData()
            }
        }
        SVProgressHUD.dismiss()
    }
    
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
