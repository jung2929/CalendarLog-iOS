//
//  NoteListPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import SVProgressHUD

class NoteListPresenter: NoteListPresenterProtocol {
    var view: NoteListViewProtocol?
    var interactor: NoteListInteractorInputProtocol?
    var wireframe: NoteListWireframeProtocol?
    
    func viewDidLoad() {
        view?.initializeUI()
    }
}

extension NoteListPresenter: NoteListInteractorOutputProtocol {
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
