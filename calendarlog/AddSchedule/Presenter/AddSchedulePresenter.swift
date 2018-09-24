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
    
    func createSchedule(_ startDate: String, _ endDate: String, _ startDatetime: String, _ endDatetime: String, _ title: String, _ content: String, _ imgUrl: String, _ location: String, _ url1: String, _ url2: String, _ url3: String, _ category: Int, _ etc: String, _ isPublic: Bool) {
        self.interactor?.validateCreateSchedule(startDate, endDate, startDatetime, endDatetime, title, content, imgUrl, location, url1, url2, url3, category, etc, isPublic)
    }
    
    func updateSchedule(_ startDate: String, _ endDate: String, _ startDatetime: String, _ endDatetime: String, _ title: String, _ content: String, _ imgUrl: String, _ location: String, _ url1: String, _ url2: String, _ url3: String, _ category: Int, _ etc: String, _ isPublic: Bool, _ sequence: Int) {
        self.interactor?.validateUpdateSchedule(startDate, endDate, startDatetime, endDatetime, title, content, imgUrl, location, url1, url2, url3, category, etc, isPublic, sequence)
    }
}

extension AddSchedulePresenter: AddScheduleInteractorOutputProtocol {
    func didCreateOrUpdateSchedule() {
        self.view?.popViewController()
    }
    
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
