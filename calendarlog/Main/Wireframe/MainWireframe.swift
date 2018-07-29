//
//  MainWireframe.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 28..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class MainWireframe: MainWireframeProtocol {
    class func createMainModule() -> MainView {
        let view = MainView()
        let presenter: MainPresenterProtocol & MainInteractorOutputProtocol = MainPresenter()
        let interactor: MainInteractorInputProtocol & MainRemoteDataManagerOutputProtocol = MainInteractor()
        let remoteDataManager: MainRemoteDataManagerInputProtocol = MainRemoteDataManager()
        let wireframe: MainWireframeProtocol = MainWireframe()

        view.presenter = presenter
        presenter.view = view
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
    
    func presentUserInfo(from view: MainViewProtocol) {
        if let sourceView = view as? UIViewController {
            let userInfoViewController = UserInfoWireframe.createUserInfoModule()
            sourceView.navigationController?.pushViewController(userInfoViewController, animated: true)
        }
    }
    
    func presentNoteList(from view: MainViewProtocol) {
        if let sourceView = view as? UIViewController {
            let noteListViewController = NoteListWireframe.createNoteListModule()
            sourceView.navigationController?.pushViewController(noteListViewController, animated: true)
        }
    }
    
    func presentScheduleDetail(from view: MainViewProtocol, with feed: Feed) {
        if let sourceView = view as? UIViewController {
            let scheduleDetailViewController = ScheduleDetailWireframe.createScheduleDetailModule()
            scheduleDetailViewController.feedValue = feed
            sourceView.navigationController?.pushViewController(scheduleDetailViewController, animated: true)
        }
    }
    
    func presentScheduleList(from view: MainViewProtocol, with date: String) {
        if let sourceView = view as? UIViewController {
            let scheduleListViewController = ScheduleListWireframe.createScheduleListModule()
            scheduleListViewController.dateValue = date
            sourceView.navigationController?.pushViewController(scheduleListViewController, animated: true)
        }
    }
    
    func presentScheduleForAdd(from view: MainViewProtocol, with date: String, _ yearIndex: Int, _ monthIndex: Int, _ dayIndex: Int) {
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
