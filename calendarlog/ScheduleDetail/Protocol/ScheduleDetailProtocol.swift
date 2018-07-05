//
//  ScheduleDetailProtocol.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol ScheduleDetailWireframeProtocol: class {
    static func createScheduleDetailModule() -> ScheduleDetailView
    
    // PRESENTER -> WIREFRAME
}

protocol ScheduleDetailViewProtocol: class {
    var presenter: ScheduleDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func initializeUI()
}

protocol ScheduleDetailPresenterProtocol: class {
    var view: ScheduleDetailViewProtocol? { get set }
    var interactor: ScheduleDetailInteractorInputProtocol? { get set }
    var wireframe: ScheduleDetailWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol ScheduleDetailInteractorInputProtocol: class {
    var presenter: ScheduleDetailInteractorOutputProtocol? { get set }
    var remoteDatamanager: ScheduleDetailRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol ScheduleDetailInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func onError(_ message: String)
}

protocol ScheduleDetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ScheduleDetailRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
}

protocol ScheduleDetailRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onError(_ message: String)
}
