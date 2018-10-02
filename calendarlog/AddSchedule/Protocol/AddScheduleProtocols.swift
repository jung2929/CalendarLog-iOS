//
//  AddScheduleProtocols.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit
import Alamofire

protocol AddScheduleWireframeProtocol: class {
    static func createAddScheduleModule() -> AddScheduleView
    
    // PRESENTER -> WIREFRAME
}

protocol AddScheduleViewProtocol: class {
    var isSelectedScheduleImage: Bool { get set }
    var isEditSchedule: Bool { get set }
    var sequence: Int { get set }
    
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
    
    func popViewController()
    
    func presentCamera()
    
    func presentAlbum()
}

protocol AddSchedulePresenterProtocol: class {
    var view: AddScheduleViewProtocol? { get set }
    var interactor: AddScheduleInteractorInputProtocol? { get set }
    var wireframe: AddScheduleWireframeProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func createSchedule(_ startDate: String, _ endDate: String, _ startDatetime: String, _ endDatetime: String,
                        _ title: String, _ content: String, _ scheduleImage: UIImage?, _ location: String, _ url1: String,
                        _ url2: String, _ url3: String, _ category: Int, _ etc: String, _ isPublic: Bool)
    
    func updateSchedule(_ startDate: String, _ endDate: String, _ startDatetime: String, _ endDatetime: String,
                        _ title: String, _ content: String, _ scheduleImage: UIImage?, _ location: String, _ url1: String,
                        _ url2: String, _ url3: String, _ category: Int, _ etc: String, _ isPublic: Bool,
                        _ sequence: Int)
}

protocol AddScheduleInteractorInputProtocol: class {
    var presenter: AddScheduleInteractorOutputProtocol? { get set }
    var remoteDatamanager: AddScheduleRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func validateCreateSchedule(_ startDate: String, _ endDate: String, _ startDatetime: String, _ endDatetime: String,
                                _ title: String, _ content: String, _ scheduleImage: UIImage?, _ location: String, _ url1: String,
                                _ url2: String, _ url3: String, _ category: Int, _ etc: String, _ isPublic: Bool)
    
    func validateUpdateSchedule(_ startDate: String, _ endDate: String, _ startDatetime: String, _ endDatetime: String,
                                _ title: String, _ content: String, _ scheduleImage: UIImage?, _ location: String, _ url1: String,
                                _ url2: String, _ url3: String, _ category: Int, _ etc: String, _ isPublic: Bool,
                                _ sequence: Int)
}

protocol AddScheduleInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didCreateOrUpdateSchedule()
    
    func onError(_ message: String)
}

protocol AddScheduleRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: AddScheduleRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func tryCreateSchedule(_ parameters: Parameters)
    
    func tryUpdateSchedule(_ parameters: Parameters)
}

protocol AddScheduleRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func didCreateOrUpdateSchedule()
    
    func onError(with message: String)
}
