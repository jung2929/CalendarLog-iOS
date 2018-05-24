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
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    
//    func didRetrievePosts(_ posts: [PostModel]) {
//        view?.hideLoading()
//        view?.showPosts(with: posts)
//    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
    
}
