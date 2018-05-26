//
//  LoginPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 24..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class LoginPresenter: LoginPresenterProtocol {
    var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireFrame: LoginWireFrameProtocol?
    
    func viewDidLoad() {
        view?.initializeUI()
    }
    
    func pressedLoginOrRegisterButton(_ email: String) {
        interactor?.retrieveEmail(email)
    }
    
    func pressedLoginButton(_ email: String, _ password: String) {
        interactor?.tryLogin(email, password)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func didRetrieveEmail() {
        view?.addSubviewPassword()
    }
    
    func didNotRetrieveEmail() {
        view?.moveToRegister()
    }
    
    func didTryLogin() {
        view?.moveToMain()
    }
    
    func onError(with message: String) {
        view?.hideLoading()
        view?.showErrorForPassword(with: message)
    }
    
}
