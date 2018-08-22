//
//  LoginProtocols.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 24..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol LoginWireframeProtocol: class {
    static func createLoginModule() -> LoginView
    
    // PRESENTER -> WIREFRAME
    func presentRegister(from view: LoginViewProtocol, with email: String)
    
    func presentMain(from view: LoginViewProtocol)
}

protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func pressedLoginOrRegisterButton()
    
    func addSubviewPassword()
    
    func pressedLoginButton()
    
    func showErrorForEmail(with message: String)
    
    func showErrorForPassword(with message: String)
    
    func initializeUI()
}

protocol LoginPresenterProtocol: class {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireframe: LoginWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func pressedLoginOrRegisterButton(_ email: String)
    
    func pressedLoginButton(_ email: String, _ password: String)
}

protocol LoginInteractorInputProtocol: class {
    var presenter: LoginInteractorOutputProtocol? { get set }
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol? { get set }

    // PRESENTER -> INTERACTOR
    func retrieveEmail(_ email: String)
    
    func validateLogin(_ email: String, _ password: String)
}

protocol LoginInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveEmail()
    
    func didNotRetrieveEmail(_ email: String)
    
    func didTryLogin()
    
    func onErrorForEmail(with message: String)
    
    func onErrorForPassword(with message: String)
}

protocol LoginRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol? { get set }

    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveEmail(_ email: String)
    
    func tryLogin(_ email: String, _ password: String)
}

protocol LoginRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onLoginEmailRetrieved()
    
    func onLoginEmailNotRetrieved(_ email: String)
    
    func onLoginSuccess(_ email: String, _ password: String, _ nickname: String)
    
    func onErrorForEmail(with message: String)
    
    func onErrorForPassword(with message: String)
}
