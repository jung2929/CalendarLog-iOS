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
    var scheduleList: [Schedule]? { get set }
    var feedList: [Feed]? { get set }
    
    var presenter: MainPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func pushUserInfo()
    
    func pushLetter()
    
    func initializeUI()
    
    func showHUD(with message: String)
    
    func dismissHUD()
    
    func showError(with message: String)
    
    func reloadMainData()
}

protocol MainPresenterProtocol: class {
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorInputProtocol? { get set }
    var wireFrame: MainWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func pushUserInfo()
    
    func pushNotification()
}

protocol MainInteractorInputProtocol: class {
    var presenter: MainInteractorOutputProtocol? { get set }
    var remoteDatamanager: MainRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveScheduleAndFeedList(_ pageNo: Int)
}

protocol MainInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveScheduleAndFeedList(_ scheduleList: [Schedule], _ feedList: [Feed])
    
    func onError(_ message: String)
}

protocol MainRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: MainRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveScheduleAndFeedList(_ email: String, _ pageNo: Int)
}

protocol MainRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onScheduleAndFeedListRetrieved(_ scheduleList: [Schedule], _ feedList: [Feed])
    
    func onError(_ message: String)
}
