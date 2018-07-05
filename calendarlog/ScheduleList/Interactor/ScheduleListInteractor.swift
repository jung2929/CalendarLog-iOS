//
//  ScheduleListInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class ScheduleListInteractor: ScheduleListInteractorInputProtocol {
    var presenter: ScheduleListInteractorOutputProtocol?
    var remoteDatamanager: ScheduleListRemoteDataManagerInputProtocol?
    
}

extension ScheduleListInteractor: ScheduleListRemoteDataManagerOutputProtocol {
    func onError(_ message: String) {
        presenter?.onError(message)
    }
}
