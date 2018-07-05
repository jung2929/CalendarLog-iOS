//
//  LoginPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 24..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import SVProgressHUD

class LoginPresenter: LoginPresenterProtocol {
    var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireframe: LoginWireframeProtocol?
    
    func viewDidLoad() {
        self.view?.initializeUI()
    }
    
    func pressedLoginOrRegisterButton(_ email: String) {
        SVProgressHUD.show(withStatus: "이메일을 확인 중 입니다.")
        self.interactor?.retrieveEmail(email)
    }
    
    func pressedLoginButton(_ email: String, _ password: String) {
        SVProgressHUD.show(withStatus: "로그인 중 입니다.")
        self.interactor?.validateLogin(email, password)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func didRetrieveEmail() {
        SVProgressHUD.dismiss()
        self.view?.addSubviewPassword()
    }
    
    func didNotRetrieveEmail(_ email: String) {
        SVProgressHUD.dismiss()
        self.wireframe?.presentRegister(from: view!, with: email)
    }
    
    func didTryLogin() {
        SVProgressHUD.dismiss()
        self.wireframe?.presentMain(from: view!)
    }
    
    func onErrorForEmail(with message: String) {
        SVProgressHUD.dismiss()
        self.view?.showErrorForEmail(with: message)
    }
    
    func onErrorForPassword(with message: String) {
        SVProgressHUD.dismiss()
        self.view?.showErrorForPassword(with: message)
    }
    
}
