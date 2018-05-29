//
//  RegisterWireframe.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 27..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class RegisterWireFrame: RegisterWireFrameProtocol {
    class func createRegisterModule() -> RegisterView {
        let view = RegisterView()
        let presenter: RegisterPresenterProtocol & RegisterInteractorOutputProtocol = RegisterPresenter()
        let interactor: RegisterInteractorInputProtocol & RegisterRemoteDataManagerOutputProtocol = RegisterInteractor()
        let remoteDataManager: RegisterRemoteDataManagerInputProtocol = RegisterRemoteDataManager()
        let wireFrame: RegisterWireFrameProtocol = RegisterWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
    
    func presentMain(from view: RegisterViewProtocol) {
        if let sourceView = view as? UIViewController {
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainWireframe.createMainModule())
            sourceView.navigationController?.popToRootViewController(animated: true)
        }
    }
}
