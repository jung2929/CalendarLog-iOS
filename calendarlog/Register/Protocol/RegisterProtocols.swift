//
//  RegisterProtocol.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 27..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol RegisterWireframeProtocol: class {
    static func createRegisterModule() -> RegisterView
    
    // PRESENTER -> WIREFRAME
    func presentMain(from view: RegisterViewProtocol)
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
    var wireframe: RegisterWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func pressedRegisterButton(_ email: String, _ password: String, _ passwordConfirmation: String, _ nickname: String, _ sex: String, _ categoryTuples: [(Int, Int)], _ associate: String)
}

protocol RegisterInteractorInputProtocol: class {
    var presenter: RegisterInteractorOutputProtocol? { get set }
    var remoteDatamanager: RegisterRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func validateRegister(_ email: String, _ password: String, _ passwordConfirmation: String, _ nickname: String, _ sex: String, _ categoryTuples: [(Int, Int)], _ associate: String)
}

protocol RegisterInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didTryRegister()
    
    func onError(with message: String)
}

protocol RegisterRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: RegisterRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func tryRegister(with userInfo: UserInfo)
}

protocol RegisterRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onRegisterSuccess(_ email: String, _ password: String)
    
    func onError(with message: String)
}
