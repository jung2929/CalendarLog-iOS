//
//  MainProtocols.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 30..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol MainWireFrameProtocol: class {
    static func createMainModule() -> MainView
    
    // PRESENTER -> WIREFRAME
}

protocol MainViewProtocol: class {
    var presenter: MainPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func pushUserInfo()
    
    func pushNotification()
    
    func initializeUI()
    
    func showError(with message: String)
}

protocol MainPresenterProtocol: class {
    var view: MainViewProtocol? { get set }
    //var interactor: RegisterInteractorInputProtocol? { get set }
    var wireFrame: MainWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func pushUserInfo()
    
    func pushNotification()
}
