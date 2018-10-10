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
    var commentList: [Comment]? { get set }
    var sequence: Int? { get set }
    
    var presenter: ScheduleDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func loadScheduleDetail()
    
    func loadCommentList()
    
    func addCommentToList()
    
    func pushCommentAddButton()
    
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
    
    func viewWillAppear(_ scheduleEmail: String, _ scheduleSequence: Int)
    
    func createComment(_ scheduleEmail: String, _ scheduleSequence: Int, _ content: String)
    
    func presentScheduleForEdit()
}

protocol ScheduleDetailInteractorInputProtocol: class {
    var presenter: ScheduleDetailInteractorOutputProtocol? { get set }
    var remoteDatamanager: ScheduleDetailRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveCommentList(_ scheduleEmail: String, _ scheduleSequence: Int)
    
    func createComment(_ scheduleEmail: String, _ scheduleSequence: Int, _ content: String)
}

protocol ScheduleDetailInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveCommentList(_ commentList: [Comment])
    
    func didCreateComment(_ comment: Comment)
    
    func onError(_ message: String)
}

protocol ScheduleDetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ScheduleDetailRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveCommentList(_ scheduleEmail: String, _ scheduleSequence: Int)
    
    func tryCreateComment(_ scheduleEmail: String, _ scheduleSequence: Int, _ email: String, _ content: String)
}

protocol ScheduleDetailRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onCommentListRetrieved(_ commentList: [Comment])
    
    func onCommentCreated(_ comment: Comment)
    
    func onError(_ message: String)
}
