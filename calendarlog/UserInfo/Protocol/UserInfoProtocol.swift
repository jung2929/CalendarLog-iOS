//
//  UserInfoProtocol.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol UserInfoWireframeProtocol: class {
    static func createUserInfoModule() -> UserInfoView
    
    // PRESENTER -> WIREFRAME
    func presentScheduleDetail(from view: UserInfoViewProtocol, with feed: Feed)
    
    func presentEdit(from view: UserInfoViewProtocol)
    
    func presentSettings(from view: UserInfoViewProtocol)
}

protocol UserInfoViewProtocol: class {
    var presenter: UserInfoPresenterProtocol? { get set }
    var feedList: [Feed]? { get set }
    
    // PRESENTER -> VIEW
    func initializeUI()
    
    func setLikedScheduleCount(_ count: String)
    
    func pushEdit()
    
    func pushSettings()
    
    func reloadFeed()
}

protocol UserInfoPresenterProtocol: class {
    var view: UserInfoViewProtocol? { get set }
    var interactor: UserInfoInteractorInputProtocol? { get set }
    var wireframe: UserInfoWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func viewWillAppear()
    
    func detectEndOfScroll(_ row: Int)
    
    func presentScheduleDetail(with feed: Feed)
    
    func presentEdit()
    
    func presentSettings()
}

protocol UserInfoInteractorInputProtocol: class {
    var presenter: UserInfoInteractorOutputProtocol? { get set }
    var remoteDatamanager: UserInfoRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveFeedList(_ row: Int)
}

protocol UserInfoInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveFeedList(_ feedList: [Feed], _ count: String)
    
    func onError(_ message: String)
}

protocol UserInfoRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: UserInfoRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveFeedList(_ email: String, _ row: Int)
}

protocol UserInfoRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onFeedListRetrieved(_ feedList: [Feed], _ row: Int, _ count: String)
    
    func onError(_ message: String)
}
