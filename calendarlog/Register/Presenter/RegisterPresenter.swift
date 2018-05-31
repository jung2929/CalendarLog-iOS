//
//  RegisterPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 27..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class RegisterPresenter: RegisterPresenterProtocol {
    var view: RegisterViewProtocol?
    var interactor: RegisterInteractorInputProtocol?
    var wireFrame: RegisterWireframeProtocol?
    
    func viewDidLoad() {
        self.view?.initializeUI()
    }
    
    func pressedRegisterButton(_ email: String, _ password: String, _ passwordConfirmation: String,
                               _ nickname: String, _ sex: String, _ categoryTuples: [(Int, Int)], _ associate: String) {
        self.interactor?.validateRegister(email, password, passwordConfirmation, nickname, sex, categoryTuples, associate)
    }
}

extension RegisterPresenter: RegisterInteractorOutputProtocol {
    func didTryRegister() {
        self.wireFrame?.presentMain(from: view!)
    }
    
    func onError(with message: String) {
        self.view?.showError(with: message)
    }
}
