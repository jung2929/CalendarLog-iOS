//
//  RegisterPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 27..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import SVProgressHUD

class RegisterPresenter: RegisterPresenterProtocol {
    var view: RegisterViewProtocol?
    var interactor: RegisterInteractorInputProtocol?
    var wireframe: RegisterWireframeProtocol?
    
    func viewDidLoad() {
        self.view?.initializeUI()
    }
    
    func pressedRegisterButton(_ email: String, _ password: String, _ passwordConfirmation: String,
                               _ nickname: String, _ sex: String, _ categoryTuples: [(Int, Int)], _ associate: String) {
        SVProgressHUD.show(withStatus: "회원가입을 진행 중 입니다.")
        self.interactor?.validateRegister(email, password, passwordConfirmation, nickname, sex, categoryTuples, associate)
    }
}

extension RegisterPresenter: RegisterInteractorOutputProtocol {
    func didTryRegister() {
        SVProgressHUD.dismiss()
        self.wireframe?.presentMain(from: view!)
    }
    
    func onError(with message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
