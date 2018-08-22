//
//  EditInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Foundation

class EditInteractor: EditInteractorInputProtocol {
    var presenter: EditInteractorOutputProtocol?
    var remoteDatamanager: EditRemoteDataManagerInputProtocol?
    
}

extension EditInteractor: EditRemoteDataManagerOutputProtocol {
    func onError(_ message: String) {
        presenter?.onError(message)
    }
}
