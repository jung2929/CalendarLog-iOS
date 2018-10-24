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
    
    func presentScheduleForEdit(from view: ScheduleDetailViewProtocol,
                                _ startYearIndex: Int, _ startMonthIndex: Int, _ startDayIndex: Int,
                                _ startHourIndex: Int, _ startMinuteIndex: Int,
                                _ endYearIndex: Int, _ endMonthIndex: Int, _ endDayIndex: Int,
                                _ endHourIndex: Int, _ endMinuteIndex: Int,
                                _ feedValue: Feed) {
        if let sourceView = view as? UIViewController {
            let addScheduleViewController = AddScheduleWireframe.createAddScheduleModule()
            addScheduleViewController.startDateValue = feedValue.startDatetime
            addScheduleViewController.startYearIndexValue = startYearIndex
            addScheduleViewController.startMonthIndexValue = startMonthIndex
            addScheduleViewController.startDayIndexValue = startDayIndex
            addScheduleViewController.startHourIndexValue = startHourIndex
            addScheduleViewController.startMinuteIndexValue = startMinuteIndex
            addScheduleViewController.endDateValue = feedValue.endDatetime
            addScheduleViewController.endYearIndexValue = endYearIndex
            addScheduleViewController.endMonthIndexValue = endMonthIndex
            addScheduleViewController.endDayIndexValue = endDayIndex
            addScheduleViewController.endHourIndexValue = endHourIndex
            addScheduleViewController.endMinuteIndexValue = endMinuteIndex
            addScheduleViewController.isEditSchedule = true
            addScheduleViewController.feedValue = feedValue
            sourceView.navigationController?.pushViewController(addScheduleViewController, animated: true)
        }
    }
}
