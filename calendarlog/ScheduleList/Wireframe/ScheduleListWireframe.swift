//
//  ScheduleListWireframe.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class ScheduleListWireframe: ScheduleListWireframeProtocol {
    static func createScheduleListModule() -> ScheduleListView {
        let view = ScheduleListView()
        let presenter: ScheduleListPresenterProtocol & ScheduleListInteractorOutputProtocol = ScheduleListPresenter()
        let interactor: ScheduleListInteractorInputProtocol & ScheduleListRemoteDataManagerOutputProtocol = ScheduleListInteractor()
        let remoteDataManager: ScheduleListRemoteDataManagerInputProtocol = ScheduleListRemoteDataManager()
        let wireframe: ScheduleListWireframeProtocol = ScheduleListWireframe()
        
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
