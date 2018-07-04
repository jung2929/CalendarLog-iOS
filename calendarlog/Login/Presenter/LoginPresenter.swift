//
//  LoginPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 24..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {
    var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireFrame: LoginWireframeProtocol?
    
    func viewDidLoad() {
        if UserDefaults.standard.bool(forKey: "isAutoLogin") {
            self.interactor?.validateLogin(
                UserDefaults.standard.string(forKey: "email")!,
                UserDefaults.standard.string(forKey: "password")!
            )
        } else {
            self.view?.initializeUI()
        }
    }
    
    func pressedLoginOrRegisterButton(_ email: String) {
        self.interactor?.retrieveEmail(email)
    }
    
    func pressedLoginButton(_ email: String, _ password: String) {
        self.interactor?.validateLogin(email, password)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func didRetrieveEmail() {
        self.view?.addSubviewPassword()
    }
    
    func didNotRetrieveEmail(_ email: String) {
        self.wireFrame?.presentRegister(from: view!, with: email)
    }
    
    func didTryLogin() {
        self.wireFrame?.presentMain(from: view!)
    }
    
    func onErrorForEmail(with message: String) {
        self.view?.showErrorForEmail(with: message)
    }
    
    func onErrorForPassword(with message: String) {
        self.view?.showErrorForPassword(with: message)
    }
    
}
