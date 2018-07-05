//
//  UserInfoProtocol.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol UserInfoWireframeProtocol: class {
    static func createUserInfoModule() -> UserInfoView
    
    // PRESENTER -> WIREFRAME
}

protocol UserInfoViewProtocol: class {
    var presenter: UserInfoPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func initializeUI()
}

protocol UserInfoPresenterProtocol: class {
    var view: UserInfoViewProtocol? { get set }
    var interactor: UserInfoInteractorInputProtocol? { get set }
    var wireframe: UserInfoWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol UserInfoInteractorInputProtocol: class {
    var presenter: UserInfoInteractorOutputProtocol? { get set }
    var remoteDatamanager: UserInfoRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol UserInfoInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func onError(_ message: String)
}

protocol UserInfoRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: UserInfoRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
}

protocol UserInfoRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onError(_ message: String)
}
