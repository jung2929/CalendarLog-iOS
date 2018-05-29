//
//  LoginInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 24..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Foundation

class LoginInteractor: LoginInteractorInputProtocol {
    weak var presenter: LoginInteractorOutputProtocol?
    var localDatamanager: LoginLocalDataManagerInputProtocol?
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol?
    
    func retrieveEmail(_ email: String) {
        guard email.count > 0 else {
            self.presenter?.onErrorForEmail(with: "이메일을 입력해주세요.")
            return
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if !emailTest.evaluate(with: email) {
            self.onErrorForEmail(with: "이메일을 정확하게 입력해주세요.")
            return
        }
        self.remoteDatamanager?.retrieveEmail(email)
    }
    
    func validateLogin(_ email: String, _ password: String) {
        guard password.count > 0 else {
            self.onErrorForPassword(with: "비밀번호를 입력해주세요.")
            return
        }
        self.remoteDatamanager?.tryLogin(email, password)
    }
}

extension LoginInteractor: LoginRemoteDataManagerOutputProtocol {
    func onLoginEmailRetrieved() {
        self.presenter?.didRetrieveEmail()
    }
    
    func onLoginEmailNotRetrieved(_ email: String) {
        self.presenter?.didNotRetrieveEmail(email)
    }
    
    func onLoginSuccess() {
        self.presenter?.didTryLogin()
    }
    
    func onErrorForEmail(with message: String) {
        self.presenter?.onErrorForEmail(with: message)
    }
    
    func onErrorForPassword(with message: String) {
        self.presenter?.onErrorForPassword(with: message)
    }
}
