//
//  MainInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 2..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Foundation

class MainInteractor: MainInteractorInputProtocol {
    weak var presenter: MainInteractorOutputProtocol?
    var remoteDatamanager: MainRemoteDataManagerInputProtocol?
    
    func retrieveScheduleAndFeedList() {
        let email = UserDefaults.standard.string(forKey: "email")!
        self.remoteDatamanager?.retrieveScheduleAndFeedList(email)
    }
    
    func retrieveFeedList(_ row: Int) {
        let email = UserDefaults.standard.string(forKey: "email")!
        self.remoteDatamanager?.retrieveFeedList(email, row)
    }
}

extension MainInteractor: MainRemoteDataManagerOutputProtocol {
    func onScheduleAndFeedListRetrieved(_ scheduleList: [Schedule], _ feedList: [Feed]) {
        self.presenter?.didRetrieveScheduleAndFeedList(scheduleList, feedList)
    }
    
    func onFeedListRetrieved(_ feedList: [Feed]) {
        self.presenter?.didRetrieveFeedList(feedList)
    }
    
    func onError(_ message: String) {
        self.presenter?.onError(message)
    }
}
