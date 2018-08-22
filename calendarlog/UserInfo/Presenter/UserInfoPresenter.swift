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
    
    func viewWillAppear() {
        SVProgressHUD.show(withStatus: "피드를 불러오는중입니다.")
        self.interactor?.retrieveFeedList(0)
    }
    
    func detectEndOfScroll(_ row: Int) {
        SVProgressHUD.show(withStatus: "피드를 불러오는중입니다.")
        self.interactor?.retrieveFeedList(row)
    }
    
    func presentScheduleDetail(with feed: Feed) {
        self.wireframe?.presentScheduleDetail(from: self.view!, with: feed)
    }
    
    func presentEdit() {
        self.wireframe?.presentEdit(from: self.view!)
    }
    
    func presentSettings() {
        self.wireframe?.presentSettings(from: self.view!)
    }
}

extension UserInfoPresenter: UserInfoInteractorOutputProtocol {
    func didRetrieveFeedList(_ feedList: [Feed], _ count: String) {
        if feedList.count != 0 {
            if self.view?.feedList == nil {
                self.view?.feedList = feedList
            } else {
                self.view?.feedList! += feedList
            }
            self.view?.reloadFeed()
        }
        self.view?.setLikedScheduleCount(count)
        SVProgressHUD.dismiss()
    }
    
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
