//
//  ScheduleListInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Foundation

class ScheduleListInteractor: ScheduleListInteractorInputProtocol {
    var presenter: ScheduleListInteractorOutputProtocol?
    var remoteDatamanager: ScheduleListRemoteDataManagerInputProtocol?
    
    func retrieveFeedList(_ row: Int, _ scheduleDate: String) {
        let email = UserDefaults.standard.string(forKey: "email")!
        self.remoteDatamanager?.retrieveFeedList(email, row, scheduleDate)
    }
}

extension ScheduleListInteractor: ScheduleListRemoteDataManagerOutputProtocol {
    func onFeedListRetrieved(_ feedList: [Feed], _ row: Int) {
        if row == 0 {
            self.presenter?.didRetrieveFeedListInViewWillAppear(feedList)
        } else {
            self.presenter?.didRetrieveFeedList(feedList)
        }
    }
    
    func onError(_ message: String) {
        presenter?.onError(message)
    }
}
