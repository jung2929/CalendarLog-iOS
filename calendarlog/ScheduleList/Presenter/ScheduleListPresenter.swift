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
        self.view?.initializeUI()
    }
    
    func viewWillAppear(_ scheduleDate: String) {
        SVProgressHUD.show(withStatus: "피드를 불러오는중입니다.")
        self.interactor?.retrieveFeedList(0, scheduleDate)
    }
    
    func detectEndOfScroll(_ row: Int, _ scheduleDate: String) {
        SVProgressHUD.show(withStatus: "피드를 불러오는중입니다.")
        self.interactor?.retrieveFeedList(row, scheduleDate)
    }
    
    func presentScheduleDetail(with feed: Feed) {
        self.wireframe?.presentScheduleDetail(from: self.view!, with: feed)
    }
}

extension ScheduleListPresenter: ScheduleListInteractorOutputProtocol {
    func didRetrieveFeedListInViewWillAppear(_ feedList: [Feed]) {
        self.view?.feedList = feedList
        self.view?.reloadFeed()
        SVProgressHUD.dismiss()
    }
    
    func didRetrieveFeedList(_ feedList: [Feed]) {
        if feedList.count != 0 {
            if self.view?.feedList == nil {
                self.view?.feedList = feedList
            } else {
                self.view?.feedList! += feedList
            }
            self.view?.reloadFeed()
        }
        SVProgressHUD.dismiss()
    }
    
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
