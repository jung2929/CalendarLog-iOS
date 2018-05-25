//
//  LoginProtocols.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 24..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol LoginWireFrameProtocol: class {
    static func createLoginModule() -> LoginView
    // PRESENTER -> WIREFRAME
    //func presentPostDetailScreen(from view: LoginViewProtocol, forPost post: PostModel)
}

protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    //func showPosts(with posts: [PostModel])
    
    func pressedLoginOrRegisterButton()
    
    func addSubviewPassword()
    
    func moveToRegister()
    
    func pressedLoginButton()
    
    func moveToMain()
    
    func showErrorForEmail(with errorMessage: String)
    
    func showErrorForPassword(with errorMessage: String)
    
    func showLoading()
    
    func hideLoading()
    
    func initializeUI()
}

protocol LoginPresenterProtocol: class {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func pressedLoginOrRegisterButton(_ email: String)
    func pressedLoginButton(_ email: String, _ password: String)
}

protocol LoginInteractorInputProtocol: class {
    var presenter: LoginInteractorOutputProtocol? { get set }
    var localDatamanager: LoginLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol? { get set }

    // PRESENTER -> INTERACTOR
    func retrieveEmail(_ email: String)
    
    func tryLogin(_ email: String, _ password: String)
}

protocol LoginInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveEmail()
    func didNotRetrieveEmail()
    func didTryLogin()
    func onError()
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
    func onLoginEmailNotRetrieved()
    func onLoginSuccess()
    func onError()
}

protocol LoginDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol LoginLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
    //func retrievePostList() throws -> [Post]
    //func savePost(id: Int, title: String, imageUrl: String, thumbImageUrl: String) throws
}
