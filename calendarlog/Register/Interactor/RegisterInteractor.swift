//
//  RegisterInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 27..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class RegisterInteractor: RegisterInteractorInputProtocol {
    weak var presenter: RegisterInteractorOutputProtocol?
    var remoteDatamanager: RegisterRemoteDataManagerInputProtocol?
    
}

extension RegisterInteractor: RegisterRemoteDataManagerOutputProtocol {
    
}
