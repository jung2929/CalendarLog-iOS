//
//  LicenseProtocol.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

protocol LicenseWireframeProtocol: class {
    static func createLicenseModule() -> LicenseView
    
    // PRESENTER -> WIREFRAME
}

protocol LicenseViewProtocol: class {
    var presenter: LicensePresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func initializeUI()
}

protocol LicensePresenterProtocol: class {
    var view: LicenseViewProtocol? { get set }
    var interactor: LicenseInteractorInputProtocol? { get set }
    var wireframe: LicenseWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol LicenseInteractorInputProtocol: class {
    var presenter: LicenseInteractorOutputProtocol? { get set }
    var remoteDatamanager: LicenseRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol LicenseInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    
    func onError(_ message: String)
}

protocol LicenseRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: LicenseRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
}

protocol LicenseRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func onError(_ message: String)
}
