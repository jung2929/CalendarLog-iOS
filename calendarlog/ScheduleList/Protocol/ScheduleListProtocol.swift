//
//  ScheduleListProtocol.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol ScheduleListWireframeProtocol: class {
    static func createScheduleListModule() -> ScheduleListView
    
    // PRESENTER -> WIREFRAME
}

protocol ScheduleListViewProtocol: class {
    var presenter: ScheduleListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func initializeUI()
}

protocol ScheduleListPresenterProtocol: class {
    var view: ScheduleListViewProtocol? { get set }
    var interactor: ScheduleListInteractorInputProtocol? { get set }
    var wireframe: ScheduleListWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol ScheduleListInteractorInputProtocol: class {
    var presenter: ScheduleListInteractorOutputProtocol? { get set }
    var remoteDatamanager: ScheduleListRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol ScheduleListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func onError(_ message: String)
}

protocol ScheduleListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ScheduleListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
}

protocol ScheduleListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onError(_ message: String)
}
