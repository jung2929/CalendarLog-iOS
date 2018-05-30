//
//  MainPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 30..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class MainPresenter: MainPresenterProtocol {
    var view: MainViewProtocol?
    
    var wireFrame: MainWireFrameProtocol?
    
    func viewDidLoad() {
        view?.initializeUI()
    }
    
    func pushUserInfo() {
        //
    }
    
    func pushNotification() {
        //
    }
}
