//
//  AddScheduleProtocols.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

protocol AddScheduleWireframeProtocol: class {
    static func createAddScheduleModule() -> AddScheduleView
    
    // PRESENTER -> WIREFRAME
}

protocol AddScheduleViewProtocol: class {
    var startDateValue: String { get set }
    var startYearIndexValue: Int { get set }
    var startMonthIndexValue: Int { get set }
    var startDayIndexValue: Int { get set }
    var startHourIndexValue: Int { get set }
    var startMinuteIndexValue: Int { get set }
    
    var endDateValue: String { get set }
    var endYearIndexValue: Int { get set }
    var endMonthIndexValue: Int { get set }
    var endDayIndexValue: Int { get set }
    var endHourIndexValue: Int { get set }
    var endMinuteIndexValue: Int { get set }
    
    var presenter: AddSchedulePresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func pushImageUploadButton()
    
    func findMaxDayIndex(with monthIndex: Int) -> Int
    
    func pushDone()
    
    func pushStartDateDone()
    
    func pushEndDateDone()

    func setPickerViewWithToolbar(_ textField: UITextField, _ pickerView: UIPickerView,
                                  _ yearIndex: Int, _ monthIndex: Int, _ dayIndex: Int,
                                  _ hourIndex: Int, _ minuteIndex: Int, _ doneButton: UIBarButtonItem)
    
    func initializeUI()
}

protocol AddSchedulePresenterProtocol: class {
    var view: AddScheduleViewProtocol? { get set }
    var interactor: AddScheduleInteractorInputProtocol? { get set }
    var wireframe: AddScheduleWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol AddScheduleInteractorInputProtocol: class {
    var presenter: AddScheduleInteractorOutputProtocol? { get set }
    var remoteDatamanager: AddScheduleRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol AddScheduleInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func onError(_ message: String)
}

protocol AddScheduleRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: AddScheduleRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
}

protocol AddScheduleRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onError(_ message: String)
}
