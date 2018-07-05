//
//  AddScheduleWireframe.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class AddScheduleWireframe: AddScheduleWireframeProtocol {
    static func createAddScheduleModule() -> AddScheduleView {
        let view = AddScheduleView()
        let presenter: AddSchedulePresenterProtocol & AddScheduleInteractorOutputProtocol = AddSchedulePresenter()
        let interactor: AddScheduleInteractorInputProtocol & AddScheduleRemoteDataManagerOutputProtocol = AddScheduleInteractor()
        let remoteDataManager: AddScheduleRemoteDataManagerInputProtocol = AddScheduleRemoteDataManager()
        let wireframe: AddScheduleWireframeProtocol = AddScheduleWireframe()
        
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
