//
//  LoginProtocols.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 24..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    //func showPosts(with posts: [PostModel])
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
    
    func initializeUI()
}

protocol LoginWireFrameProtocol: class {
    static func createLoginModule() -> LoginView
    // PRESENTER -> WIREFRAME
    //func presentPostDetailScreen(from view: LoginViewProtocol, forPost post: PostModel)
}

protocol LoginPresenterProtocol: class {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    //func showPostDetail(forPost post: PostModel)
}

protocol LoginInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    //func didRetrievePosts(_ posts: [PostModel])
    func onError()
}

protocol LoginInteractorInputProtocol: class {
    var presenter: LoginInteractorOutputProtocol? { get set }
    var localDatamanager: LoginLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol? { get set }

    // PRESENTER -> INTERACTOR
    //func retrievePostList()
}

protocol LoginDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol LoginRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol? { get set }

    // INTERACTOR -> REMOTEDATAMANAGER
    func retrievePostList()
}

protocol LoginRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    //func onPostsRetrieved(_ posts: [PostModel])
    func onError()
}

protocol LoginLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
    //func retrievePostList() throws -> [Post]
    func savePost(id: Int, title: String, imageUrl: String, thumbImageUrl: String) throws
}
