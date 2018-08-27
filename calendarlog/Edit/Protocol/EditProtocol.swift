//
//  EditProtocol.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

protocol EditWireframeProtocol: class {
    static func createEditModule() -> EditView
    
    // PRESENTER -> WIREFRAME
}

protocol EditViewProtocol: class {
    var presenter: EditPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func initializeUI()
    
    func pushDone()
    
    func pressedSexButton(_ sender: UIButton)
    
    func pressedCategoryButton(_ sender: UIButton)
    
    func addCategories()
    
    func setEditUserInfo(_ sex: String, _ categories: [Int], _ associate: String)
}

protocol EditPresenterProtocol: class {
    var view: EditViewProtocol? { get set }
    var interactor: EditInteractorInputProtocol? { get set }
    var wireframe: EditWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func pushDone(_ email: String, _ password: String, _ passwordConfirmation: String, _ nickname: String, _ sex: String, _ categoryTuples: [(Int, Int)], _ associate: String)
}

protocol EditInteractorInputProtocol: class {
    var presenter: EditInteractorOutputProtocol? { get set }
    var remoteDatamanager: EditRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveEditUserInfo()
    
    func validateUpdateUserInfo(_ email: String, _ password: String, _ passwordConfirmation: String, _ nickname: String, _ sex: String, _ categoryTuples: [(Int, Int)], _ associate: String)
}

protocol EditInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didTryUpdateUserInfo()
    
    func didRetrieveEditUserInfo(_ sex: String, _ categories: [Int], _ associate: String)
    
    func onError(_ message: String)
}

protocol EditRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: EditRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveEditUserInfo(_ email: String)
    
    func tryUpdateUserInfo(with userInfo: UserInfo)
}

protocol EditRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func didRetrieveEditUserInfo(_ sex: String, _ categories: [Int], _ associate: String)
    
    func didUpdateUserInfo()
    
    func onError(_ message: String)
}
