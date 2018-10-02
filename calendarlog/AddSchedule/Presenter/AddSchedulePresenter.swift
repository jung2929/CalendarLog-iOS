//
//  AddSchedulePresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import SVProgressHUD

class AddSchedulePresenter: AddSchedulePresenterProtocol {
    var view: AddScheduleViewProtocol?
    var interactor: AddScheduleInteractorInputProtocol?
    var wireframe: AddScheduleWireframeProtocol?
    
    func viewDidLoad() {
        view?.initializeUI()
    }
    
    func createSchedule(_ startDate: String, _ endDate: String, _ startDatetime: String, _ endDatetime: String, _ title: String, _ content: String, _ scheduleImage: UIImage?, _ location: String, _ url1: String, _ url2: String, _ url3: String, _ category: Int, _ etc: String, _ isPublic: Bool) {
        SVProgressHUD.show(withStatus: "스케줄을 등록중 입니다.")
        self.interactor?.validateCreateSchedule(startDate, endDate, startDatetime, endDatetime, title, content, scheduleImage, location, url1, url2, url3, category, etc, isPublic)
    }
    
    func updateSchedule(_ startDate: String, _ endDate: String, _ startDatetime: String, _ endDatetime: String, _ title: String, _ content: String, _ scheduleImage: UIImage?, _ location: String, _ url1: String, _ url2: String, _ url3: String, _ category: Int, _ etc: String, _ isPublic: Bool, _ sequence: Int) {
        SVProgressHUD.show(withStatus: "스케줄을 수정중 입니다.")
        self.interactor?.validateUpdateSchedule(startDate, endDate, startDatetime, endDatetime, title, content, scheduleImage, location, url1, url2, url3, category, etc, isPublic, sequence)
    }
}

extension AddSchedulePresenter: AddScheduleInteractorOutputProtocol {
    func didCreateOrUpdateSchedule() {
        SVProgressHUD.dismiss()
        self.view?.popViewController()
    }
    
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
