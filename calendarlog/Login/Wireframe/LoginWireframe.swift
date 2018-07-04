//
//  LoginWireframe.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 24..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class LoginWireframe: LoginWireframeProtocol {
    class func createLoginModule() -> LoginView {
        let view = LoginView()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol & LoginRemoteDataManagerOutputProtocol = LoginInteractor()
        let remoteDataManager: LoginRemoteDataManagerInputProtocol = LoginRemoteDataManager()
        let wireFrame: LoginWireframeProtocol = LoginWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
    
    func presentRegister(from view: LoginViewProtocol, with email: String) {
        if let sourceView = view as? UIViewController {
            let registerViewController = RegisterWireframe.createRegisterModule()
            registerViewController.emailValue = email
            sourceView.navigationController?.pushViewController(registerViewController, animated: true)
        }
    }
    
    func presentMain(from view: LoginViewProtocol) {
        if let sourceView = view as? UIViewController {
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainWireframe.createMainModule())
            sourceView.navigationController?.popToRootViewController(animated: true)
        }
    }
}
