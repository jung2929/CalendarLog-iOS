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
    
    func retrieveCommentList(_ scheduleEmail: String, _ scheduleSequence: Int) {
        self.remoteDatamanager?.retrieveCommentList(scheduleEmail, scheduleSequence)
    }
    
    func createComment(_ scheduleEmail: String, _ scheduleSequence: Int, _ content: String) {
        let email = UserDefaults.standard.string(forKey: "email")!
        self.remoteDatamanager?.tryCreateComment(scheduleEmail, scheduleSequence, email, content)
    }
}

extension ScheduleDetailInteractor: ScheduleDetailRemoteDataManagerOutputProtocol {
    func onCommentListRetrieved(_ commentList: [Comment]) {
        self.presenter?.didRetrieveCommentList(commentList)
    }
    
    func onCommentCreated(_ comment: Comment) {
        self.presenter?.didCreateComment(comment)
    }
    
    func onError(_ message: String) {
        presenter?.onError(message)
    }
}
