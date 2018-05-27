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
    var wireFrame: RegisterWireFrameProtocol?
    
    func viewDidLoad() {
        view?.initializeUI()
    }
    
    func viewDidAppear() {
        view?.addCategories()
    }
}

extension RegisterPresenter: RegisterInteractorOutputProtocol {

}
