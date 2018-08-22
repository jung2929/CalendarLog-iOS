//
//  EditWireframe.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class EditWireframe: EditWireframeProtocol {
    static func createEditModule() -> EditView {
        let view = EditView()
        let presenter: EditPresenterProtocol & EditInteractorOutputProtocol = EditPresenter()
        let interactor: EditInteractorInputProtocol & EditRemoteDataManagerOutputProtocol = EditInteractor()
        let remoteDataManager: EditRemoteDataManagerInputProtocol = EditRemoteDataManager()
        let wireframe: EditWireframeProtocol = EditWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
}
