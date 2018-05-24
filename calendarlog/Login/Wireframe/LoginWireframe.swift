//
//  LoginWireframe.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 24..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class LoginWireFrame: LoginWireFrameProtocol {
    class func createLoginModule() -> LoginView {
        let view = LoginView()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol & LoginRemoteDataManagerOutputProtocol = LoginInteractor()
        let localDataManager: LoginLocalDataManagerInputProtocol = LoginLocalDataManager()
        let remoteDataManager: LoginRemoteDataManagerInputProtocol = LoginRemoteDataManager()
        let wireFrame: LoginWireFrameProtocol = LoginWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
}
