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
    var feedValue: Feed? { get set }
    var sequence: Int? { get set }
    
    var presenter: ScheduleDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func loadScheduleDetail()
    
    func pushLikeButton()
    
    func pushEdit()
    
    func initializeUI()
}

protocol ScheduleDetailPresenterProtocol: class {
    var view: ScheduleDetailViewProtocol? { get set }
    var interactor: ScheduleDetailInteractorInputProtocol? { get set }
    var wireframe: ScheduleDetailWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func viewWillAppear()
    
    func presentScheduleForEdit()
}

protocol ScheduleDetailInteractorInputProtocol: class {
    var presenter: ScheduleDetailInteractorOutputProtocol? { get set }
    var remoteDatamanager: ScheduleDetailRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveScheduleDetail(_ sequence: Int)
}

protocol ScheduleDetailInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveScheduleDetail(_ feedList: [Feed])
    
    func onError(_ message: String)
}

protocol ScheduleDetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ScheduleDetailRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveScheduleDetail(_ email: String, _ sequence: Int)
}

protocol ScheduleDetailRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onScheduleDetailRetrieved()
    
    func onError(_ message: String)
}
