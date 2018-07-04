//
//  MainInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 2..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class MainInteractor: MainInteractorInputProtocol {
    weak var presenter: MainInteractorOutputProtocol?
    var remoteDatamanager: MainRemoteDataManagerInputProtocol?
    
    func retrieveScheduleAndFeedList(_ pageNo: Int) {
        remoteDatamanager?.retrieveScheduleAndFeedList("dngus@dngus.com", pageNo)
    }
}

extension MainInteractor: MainRemoteDataManagerOutputProtocol {
    func onScheduleAndFeedListRetrieved(_ scheduleList: [Schedule], _ feedList: [Feed]) {
        presenter?.didRetrieveScheduleAndFeedList(scheduleList, feedList)
    }
    
    func onError(_ message: String) {
        presenter?.onError(message)
    }
}
