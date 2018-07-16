//
//  AddScheduleProtocols.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol AddScheduleWireframeProtocol: class {
    static func createAddScheduleModule() -> AddScheduleView
    
    // PRESENTER -> WIREFRAME
}

protocol AddScheduleViewProtocol: class {
    var dateValue: String? { get set }
    
    var presenter: AddSchedulePresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func initializeUI()
}

protocol AddSchedulePresenterProtocol: class {
    var view: AddScheduleViewProtocol? { get set }
    var interactor: AddScheduleInteractorInputProtocol? { get set }
    var wireframe: AddScheduleWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol AddScheduleInteractorInputProtocol: class {
    var presenter: AddScheduleInteractorOutputProtocol? { get set }
    var remoteDatamanager: AddScheduleRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol AddScheduleInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func onError(_ message: String)
}

protocol AddScheduleRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: AddScheduleRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
}

protocol AddScheduleRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onError(_ message: String)
}
