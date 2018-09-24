//
//  AddScheduleInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Alamofire

class AddScheduleInteractor: AddScheduleInteractorInputProtocol {
    var presenter: AddScheduleInteractorOutputProtocol?
    var remoteDatamanager: AddScheduleRemoteDataManagerInputProtocol?
    
    func validateCreateSchedule(_ startDate: String, _ endDate: String, _ startDatetime: String, _ endDatetime: String, _ title: String, _ content: String, _ imgUrl: String, _ location: String, _ url1: String, _ url2: String, _ url3: String, _ category: Int, _ etc: String, _ isPublic: Bool) {
        let email = UserDefaults.standard.string(forKey: "email")!
        let parameters: Parameters = ["email": email, "start_date": startDate, "end_date": endDate,
                                      "start_datetime": startDatetime, "end_datetime": endDatetime,
                                      "title": title, "content": content, "img_url": imgUrl, "location": location,
                                      "url1": url1, "url2": url2, "url3": url3, "category": category,
                                      "etc": etc, "is_public": isPublic]
        self.remoteDatamanager?.tryCreateSchedule(parameters)
    }
    
    func validateUpdateSchedule(_ startDate: String, _ endDate: String, _ startDatetime: String, _ endDatetime: String, _ title: String, _ content: String, _ imgUrl: String, _ location: String, _ url1: String, _ url2: String, _ url3: String, _ category: Int, _ etc: String, _ isPublic: Bool, _ sequence: Int) {
        let email = UserDefaults.standard.string(forKey: "email")!
        let parameters: Parameters = ["email": email, "start_date": startDate, "end_date": endDate,
                                      "start_datetime": startDatetime, "end_datetime": endDatetime,
                                      "title": title, "content": content, "img_url": imgUrl, "location": location,
                                      "url1": url1, "url2": url2, "url3": url3, "category": category,
                                      "etc": etc, "is_public": isPublic, "sequence": sequence]
        self.remoteDatamanager?.tryUpdateSchedule(parameters)
    }
}

extension AddScheduleInteractor: AddScheduleRemoteDataManagerOutputProtocol {
    func didCreateOrUpdateSchedule() {
        self.presenter?.didCreateOrUpdateSchedule()
    }
    
    func onError(with message: String) {
        self.presenter?.onError(message)
    }
}
