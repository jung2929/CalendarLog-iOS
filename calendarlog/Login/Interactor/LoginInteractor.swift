//
//  LoginInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 24..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class LoginInteractor: LoginInteractorInputProtocol {
    weak var presenter: LoginInteractorOutputProtocol?
    var localDatamanager: LoginLocalDataManagerInputProtocol?
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol?
    
    func retrieveEmail(_ email: String) {
        remoteDatamanager?.retrieveEmail(email)
    }
    
    func tryLogin(_ email: String, _ password: String) {
        remoteDatamanager?.tryLogin(email, password)
    }
}

extension LoginInteractor: LoginRemoteDataManagerOutputProtocol {
    func onLoginEmailRetrieved() {
        presenter?.didRetrieveEmail()
    }
    
    func onLoginEmailNotRetrieved() {
        presenter?.didNotRetrieveEmail()
    }
    
    func onLoginSuccess() {
        presenter?.didTryLogin()
    }
    
    func onError(with message: String) {
        presenter?.onError(with: message)
    }
    
}
