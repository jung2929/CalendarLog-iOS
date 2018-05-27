//
//  RegisterProtocol.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 27..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol RegisterWireFrameProtocol: class {
    static func createRegisterModule() -> RegisterView
    // PRESENTER -> WIREFRAME
    //func presentPostDetailScreen(from view: LoginViewProtocol, forPost post: PostModel)
}

protocol RegisterViewProtocol: class {
    var presenter: RegisterPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    
    func initializeUI()
    func addCategories()
}

protocol RegisterPresenterProtocol: class {
    var view: RegisterViewProtocol? { get set }
    var interactor: RegisterInteractorInputProtocol? { get set }
    var wireFrame: RegisterWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func viewDidAppear()
}

protocol RegisterInteractorInputProtocol: class {
    var presenter: RegisterInteractorOutputProtocol? { get set }
    var remoteDatamanager: RegisterRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol RegisterInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
}

protocol RegisterRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: RegisterRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
}

protocol RegisterRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}
