//
//  LicenseWireframe.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class LicenseWireframe: LicenseWireframeProtocol {
    static func createLicenseModule() -> LicenseView {
        let view = LicenseView()
        let presenter: LicensePresenterProtocol & LicenseInteractorOutputProtocol = LicensePresenter()
        let interactor: LicenseInteractorInputProtocol & LicenseRemoteDataManagerOutputProtocol = LicenseInteractor()
        let remoteDataManager: LicenseRemoteDataManagerInputProtocol = LicenseRemoteDataManager()
        let wireframe: LicenseWireframeProtocol = LicenseWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
}
