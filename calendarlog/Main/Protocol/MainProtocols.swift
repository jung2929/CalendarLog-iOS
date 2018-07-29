//
//  MainProtocols.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 30..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol MainWireframeProtocol: class {
    static func createMainModule() -> MainView
    
    // PRESENTER -> WIREFRAME
    func presentUserInfo(from view: MainViewProtocol)
    
    func presentNoteList(from view: MainViewProtocol)
    
    func presentScheduleList(from view: MainViewProtocol, with date: String)
    
    func presentScheduleDetail(from view: MainViewProtocol, with feed: Feed)
    
    func presentScheduleForAdd(from view: MainViewProtocol, with date: String, _ yearIndex: Int, _ monthIndex: Int, _ dayIndex: Int)
}

protocol MainViewProtocol: class {
    var scheduleList: [Schedule]? { get set }
    var feedList: [Feed]? { get set }
    
    var presenter: MainPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func pushUserInfo()
    
    func pushNoteList()
    
    func initializeUI()
    
    func reloadMainData()
}

protocol MainPresenterProtocol: class {
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorInputProtocol? { get set }
    var wireframe: MainWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func viewWillAppear()
    
    func detectEndOfScroll(_ row: Int)
    
    func presentUserInfo()
    
    func presentNoteList()
    
    func presentScheduleList(with date: String)
    
    func presentScheduleDetail(with feed: Feed)
    
    func presentScheduleForAdd(with date: String, _ yearIndex: Int, _ monthIndex: Int, _ dayIndex: Int)
}

protocol MainInteractorInputProtocol: class {
    var presenter: MainInteractorOutputProtocol? { get set }
    var remoteDatamanager: MainRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveScheduleAndFeedList()
    
    func retrieveFeedList(_ row: Int)
}

protocol MainInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveScheduleAndFeedList(_ scheduleList: [Schedule], _ feedList: [Feed])
    
    func didRetrieveFeedList(_ feedList: [Feed])
    
    func onError(_ message: String)
}

protocol MainRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: MainRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveScheduleAndFeedList(_ email: String)
    
    func retrieveFeedList(_ email: String, _ row: Int)
}

protocol MainRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onScheduleAndFeedListRetrieved(_ scheduleList: [Schedule], _ feedList: [Feed])
    
    func onFeedListRetrieved(_ feedList: [Feed])
    
    func onError(_ message: String)
}
