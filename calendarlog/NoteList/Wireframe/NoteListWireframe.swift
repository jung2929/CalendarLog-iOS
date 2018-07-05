//
//  NoteListWireframe.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class NoteListWireframe: NoteListWireframeProtocol {
    static func createNoteListModule() -> NoteListView {
        let view = NoteListView()
        let presenter: NoteListPresenterProtocol & NoteListInteractorOutputProtocol = NoteListPresenter()
        let interactor: NoteListInteractorInputProtocol & NoteListRemoteDataManagerOutputProtocol = NoteListInteractor()
        let remoteDataManager: NoteListRemoteDataManagerInputProtocol = NoteListRemoteDataManager()
        let wireframe: NoteListWireframeProtocol = NoteListWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
}
