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
    func presentLicense(from view: SettingsViewProtocol)
    
    func presentLogin(from view: SettingsViewProtocol)
}

protocol SettingsViewProtocol: class {
    var presenter: SettingsPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func initializeUI()
    
    func switchNoteStatus(_ isReceiveNote: Bool)
    
    func pushNoteSwitch()
    
    func pushLicense()
    
    func pushLogOut()
    
    func pushDeleteUserInfo()
}

protocol SettingsPresenterProtocol: class {
    var view: SettingsViewProtocol? { get set }
    var interactor: SettingsInteractorInputProtocol? { get set }
    var wireframe: SettingsWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func updateNoteStatus(_ isReceiveNote: Bool)
    
    func presentLicense()
    
    func turnOffAutoLogin()
    
    func deleteUserInfo()
}

protocol SettingsInteractorInputProtocol: class {
    var presenter: SettingsInteractorOutputProtocol? { get set }
    var remoteDatamanager: SettingsRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func updateNoteStatus(_ isReceiveNote: Bool)
    
    func turnOffAutoLogin()
    
    func deleteUserInfo()
}

protocol SettingsInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didUpdateNoteStatus(_ isReceiveNote: Bool)
    
    func presentLogin()
    
    func onError(_ message: String)
}

protocol SettingsRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: SettingsRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func tryUpdateNoteStatus(_ email: String, _ isReceiveNote: Bool)
    
    func tryDeleteUserInfo(_ email: String)
}

protocol SettingsRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onUpdateNoteStatus(_ isReceiveNote: Bool)
    
    func onDeleteUserInfoSuccess()
    
    func onError(_ message: String)
}
