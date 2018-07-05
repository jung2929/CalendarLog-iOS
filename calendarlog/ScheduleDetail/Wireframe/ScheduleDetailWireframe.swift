//
//  ScheduleDetailWireframe.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class ScheduleDetailWireframe: ScheduleDetailWireframeProtocol {
    static func createScheduleDetailModule() -> ScheduleDetailView {
        let view = ScheduleDetailView()
        let presenter: ScheduleDetailPresenterProtocol & ScheduleDetailInteractorOutputProtocol = ScheduleDetailPresenter()
        let interactor: ScheduleDetailInteractorInputProtocol & ScheduleDetailRemoteDataManagerOutputProtocol = ScheduleDetailInteractor()
        let remoteDataManager: ScheduleDetailRemoteDataManagerInputProtocol = ScheduleDetailRemoteDataManager()
        let wireframe: ScheduleDetailWireframeProtocol = ScheduleDetailWireframe()
        
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
