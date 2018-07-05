//
//  NoteListProtocol.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol NoteListWireframeProtocol: class {
    static func createNoteListModule() -> NoteListView
    
    // PRESENTER -> WIREFRAME
}

protocol NoteListViewProtocol: class {
    var presenter: NoteListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func initializeUI()
}

protocol NoteListPresenterProtocol: class {
    var view: NoteListViewProtocol? { get set }
    var interactor: NoteListInteractorInputProtocol? { get set }
    var wireframe: NoteListWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol NoteListInteractorInputProtocol: class {
    var presenter: NoteListInteractorOutputProtocol? { get set }
    var remoteDatamanager: NoteListRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol NoteListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func onError(_ message: String)
}

protocol NoteListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: NoteListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
}

protocol NoteListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onError(_ message: String)
}
