//
//  ScheduleDetailInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class ScheduleDetailInteractor: ScheduleDetailInteractorInputProtocol {
    var presenter: ScheduleDetailInteractorOutputProtocol?
    var remoteDatamanager: ScheduleDetailRemoteDataManagerInputProtocol?
    
}

extension ScheduleDetailInteractor: ScheduleDetailRemoteDataManagerOutputProtocol {
    func onError(_ message: String) {
        presenter?.onError(message)
    }
}
