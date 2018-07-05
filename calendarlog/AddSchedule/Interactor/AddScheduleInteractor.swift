//
//  AddScheduleInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class AddScheduleInteractor: AddScheduleInteractorInputProtocol {
    var presenter: AddScheduleInteractorOutputProtocol?
    var remoteDatamanager: AddScheduleRemoteDataManagerInputProtocol?
    
}

extension AddScheduleInteractor: AddScheduleRemoteDataManagerOutputProtocol {
    func onError(_ message: String) {
        presenter?.onError(message)
    }
}
