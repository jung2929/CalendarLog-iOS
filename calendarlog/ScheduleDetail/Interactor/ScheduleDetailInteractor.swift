//
//  ScheduleDetailInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Foundation

class ScheduleDetailInteractor: ScheduleDetailInteractorInputProtocol {
    var presenter: ScheduleDetailInteractorOutputProtocol?
    var remoteDatamanager: ScheduleDetailRemoteDataManagerInputProtocol?
    
    func retrieveScheduleDetail(_ sequence: Int) {
        let email = UserDefaults.standard.string(forKey: "email")!
        self.remoteDatamanager?.retrieveScheduleDetail(email, sequence)
    }
}

extension ScheduleDetailInteractor: ScheduleDetailRemoteDataManagerOutputProtocol {
    func onScheduleDetailRetrieved() {
        //self.presenter?.didRetrieveScheduleDetail(nil)
    }
    
    func onError(_ message: String) {
        presenter?.onError(message)
    }
}
