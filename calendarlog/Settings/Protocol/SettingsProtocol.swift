//
//  SettingsProtocol.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol SettingsWireframeProtocol: class {
    static func createSettingsModule() -> SettingsView
    
    // PRESENTER -> WIREFRAME
}

protocol SettingsViewProtocol: class {
    var presenter: SettingsPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func initializeUI()
}

protocol SettingsPresenterProtocol: class {
    var view: SettingsViewProtocol? { get set }
    var interactor: SettingsInteractorInputProtocol? { get set }
    var wireframe: SettingsWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol SettingsInteractorInputProtocol: class {
    var presenter: SettingsInteractorOutputProtocol? { get set }
    var remoteDatamanager: SettingsRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol SettingsInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    
    func onError(_ message: String)
}

protocol SettingsRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: SettingsRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
}

protocol SettingsRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func onError(_ message: String)
}
