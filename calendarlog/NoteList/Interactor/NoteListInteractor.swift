//
//  NoteListInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class NoteListInteractor: NoteListInteractorInputProtocol {
    var presenter: NoteListInteractorOutputProtocol?
    var remoteDatamanager: NoteListRemoteDataManagerInputProtocol?
    
}

extension NoteListInteractor: NoteListRemoteDataManagerOutputProtocol {
    func onError(_ message: String) {
        presenter?.onError(message)
    }
}
