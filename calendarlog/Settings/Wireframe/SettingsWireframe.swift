//
//  SettingsWireframe.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

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
}
