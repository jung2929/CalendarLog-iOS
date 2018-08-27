//
//  EditInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Foundation

class EditInteractor: EditInteractorInputProtocol {
    var presenter: EditInteractorOutputProtocol?
    var remoteDatamanager: EditRemoteDataManagerInputProtocol?
    
    func retrieveEditUserInfo() {
        let email = UserDefaults.standard.string(forKey: "email")!
        self.remoteDatamanager?.retrieveEditUserInfo(email)
    }
    
    func validateUpdateUserInfo(_ email: String, _ password: String, _ passwordConfirmation: String, _ nickname: String, _ sex: String, _ categoryTuples: [(Int, Int)], _ associate: String) {
        ()
    }
}

extension EditInteractor: EditRemoteDataManagerOutputProtocol {
    func didRetrieveEditUserInfo(_ sex: String, _ categories: [Int], _ associate: String) {
        self.presenter?.didRetrieveEditUserInfo(sex, categories, associate)
    }
    
    func didUpdateUserInfo() {
        ()
    }
    
    func onError(_ message: String) {
        self.presenter?.onError(message)
    }
}
