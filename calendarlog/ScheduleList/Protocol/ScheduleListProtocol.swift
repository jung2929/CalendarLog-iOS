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
    func presentScheduleDetail(from view: ScheduleListViewProtocol, with feed: Feed)
}

protocol ScheduleListViewProtocol: class {
    var dateValue: String? { get set}
    var feedList: [Feed]? { get set }
    
    var presenter: ScheduleListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func initializeUI()
    
    func reloadFeed()
}

protocol ScheduleListPresenterProtocol: class {
    var view: ScheduleListViewProtocol? { get set }
    var interactor: ScheduleListInteractorInputProtocol? { get set }
    var wireframe: ScheduleListWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func viewWillAppear(_ scheduleDate: String)
    
    func detectEndOfScroll(_ row: Int, _ scheduleDate: String)
    
    func presentScheduleDetail(with feed: Feed)
}

protocol ScheduleListInteractorInputProtocol: class {
    var presenter: ScheduleListInteractorOutputProtocol? { get set }
    var remoteDatamanager: ScheduleListRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveFeedList(_ row: Int, _ scheduleDate: String)
}

protocol ScheduleListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveFeedListInViewWillAppear(_ feedList: [Feed])
    
    func didRetrieveFeedList(_ feedList: [Feed])
    
    func onError(_ message: String)
}

protocol ScheduleListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ScheduleListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveFeedList(_ email: String, _ row: Int, _ scheduleDate: String)
}

protocol ScheduleListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onFeedListRetrieved(_ feedList: [Feed], _ row: Int)
    
    func onError(_ message: String)
}
