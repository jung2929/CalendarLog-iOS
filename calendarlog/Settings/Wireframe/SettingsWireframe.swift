//
//  SettingsWireframe.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class SettingsWireframe: SettingsWireframeProtocol {
    static func createSettingsModule() -> SettingsView {
        let view = SettingsView()
        let presenter: SettingsPresenterProtocol & SettingsInteractorOutputProtocol = SettingsPresenter()
        let interactor: SettingsInteractorInputProtocol & SettingsRemoteDataManagerOutputProtocol = SettingsInteractor()
        let remoteDataManager: SettingsRemoteDataManagerInputProtocol = SettingsRemoteDataManager()
        let wireframe: SettingsWireframeProtocol = SettingsWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
    
    func presentLicense(from view: SettingsViewProtocol) {
        if let sourceView = view as? UIViewController {
            let settingsViewController = LicenseWireframe.createLicenseModule()
            sourceView.navigationController?.pushViewController(settingsViewController, animated: true)
        }
    }
    
    func presentLogin(from view: SettingsViewProtocol) {
        if let sourceView = view as? UIViewController {
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LoginWireframe.createLoginModule())
            sourceView.navigationController?.popToRootViewController(animated: true)
        }
    }
}
