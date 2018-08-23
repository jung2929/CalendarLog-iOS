//
//  UserInfoInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Foundation

class UserInfoInteractor: UserInfoInteractorInputProtocol {
    var presenter: UserInfoInteractorOutputProtocol?
    var remoteDatamanager: UserInfoRemoteDataManagerInputProtocol?
    
    func retrieveFeedList(_ row: Int) {
        let email = UserDefaults.standard.string(forKey: "email")!
        self.remoteDatamanager?.retrieveFeedList(email, row)
    }
}

extension UserInfoInteractor: UserInfoRemoteDataManagerOutputProtocol {
    func onFeedListRetrieved(_ feedList: [Feed], _ row: Int, _ count: String, _ nickname: String, _ isReceiveNote: String) {
        if isReceiveNote == "Y" {
            UserDefaults.standard.set(true, forKey: "isReceiveNote")
        } else {
            UserDefaults.standard.set(false, forKey: "isReceiveNote")
        }
        self.presenter?.didRetrieveFeedList(feedList, count)
    }
    
    func onError(_ message: String) {
        presenter?.onError(message)
    }
}
