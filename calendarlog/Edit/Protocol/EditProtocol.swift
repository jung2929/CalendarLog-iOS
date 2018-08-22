//
//  EditProtocol.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol EditWireframeProtocol: class {
    static func createEditModule() -> EditView
    
    // PRESENTER -> WIREFRAME
}

protocol EditViewProtocol: class {
    var presenter: EditPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func initializeUI()
    
    func pushDone()
}

protocol EditPresenterProtocol: class {
    var view: EditViewProtocol? { get set }
    var interactor: EditInteractorInputProtocol? { get set }
    var wireframe: EditWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol EditInteractorInputProtocol: class {
    var presenter: EditInteractorOutputProtocol? { get set }
    var remoteDatamanager: EditRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol EditInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    
    func onError(_ message: String)
}

protocol EditRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: EditRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
}

protocol EditRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func onError(_ message: String)
}
