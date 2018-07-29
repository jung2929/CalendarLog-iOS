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
    
    func presentScheduleDetail(from view: ScheduleListViewProtocol, with feed: Feed) {
        if let sourceView = view as? UIViewController {
            let scheduleDetailViewController = ScheduleDetailWireframe.createScheduleDetailModule()
            scheduleDetailViewController.feedValue = feed
            sourceView.navigationController?.pushViewController(scheduleDetailViewController, animated: true)
        }
    }
    
    func presentScheduleForAdd(from view: ScheduleListViewProtocol, with date: String, _ yearIndex: Int, _ monthIndex: Int, _ dayIndex: Int) {
        if let sourceView = view as? UIViewController {
            let addScheduleViewController = AddScheduleWireframe.createAddScheduleModule()
            addScheduleViewController.startDateValue = date
            addScheduleViewController.startYearIndexValue = yearIndex
            addScheduleViewController.startMonthIndexValue = monthIndex
            addScheduleViewController.startDayIndexValue = dayIndex
            addScheduleViewController.startHourIndexValue = 0
            addScheduleViewController.startMinuteIndexValue = 0
            addScheduleViewController.endDateValue = date
            addScheduleViewController.endYearIndexValue = yearIndex
            addScheduleViewController.endMonthIndexValue = monthIndex
            addScheduleViewController.endDayIndexValue = dayIndex
            addScheduleViewController.endHourIndexValue = 0
            addScheduleViewController.endMinuteIndexValue = 0
            sourceView.navigationController?.pushViewController(addScheduleViewController, animated: true)
        }
    }
}
