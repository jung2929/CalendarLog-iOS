//
//  AddScheduleInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Alamofire
import FirebaseStorage

class AddScheduleInteractor: AddScheduleInteractorInputProtocol {
    var presenter: AddScheduleInteractorOutputProtocol?
    var remoteDatamanager: AddScheduleRemoteDataManagerInputProtocol?
    
    func validateCreateSchedule(_ startDate: String, _ endDate: String, _ startDatetime: String, _ endDatetime: String, _ title: String, _ content: String, _ scheduleImage: UIImage?, _ location: String, _ url1: String, _ url2: String, _ url3: String, _ category: Int, _ etc: String, _ isPublic: Bool) {
        let email = UserDefaults.standard.string(forKey: "email")!
        
        if let scheduleImage = scheduleImage {
            let storageReference = Storage.storage().reference().child("schedules/\(email), Title:\(title).png")
            if let uploadedData: Data = UIImagePNGRepresentation(scheduleImage) {
                storageReference.putData(uploadedData, metadata: nil) { (metadata, error) in
                    storageReference.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                            self.presenter?.onError("네트워크 상의 오류로 스케줄 이미지를 업로드하는데 실패하였습니다.\n다시 시도바랍니다.")
                            return
                        }
                        let parameters: Parameters = ["email": email, "start_date": startDate, "end_date": endDate, "start_datetime": startDatetime, "end_datetime": endDatetime, "title": title, "content": content, "img_url": downloadURL.absoluteString, "location": location, "url1": url1, "url2": url2, "url3": url3, "category": category, "etc": etc, "is_public": isPublic]
                        self.remoteDatamanager?.tryCreateSchedule(parameters)
                    }
                }
            }
        } else {
            let parameters: Parameters = ["email": email, "start_date": startDate, "end_date": endDate, "start_datetime": startDatetime, "end_datetime": endDatetime, "title": title, "content": content, "img_url": "", "location": location, "url1": url1, "url2": url2, "url3": url3, "category": category, "etc": etc, "is_public": isPublic]
            self.remoteDatamanager?.tryCreateSchedule(parameters)
        }
    }
    
    func validateUpdateSchedule(_ startDate: String, _ endDate: String, _ startDatetime: String, _ endDatetime: String, _ title: String, _ content: String, _ scheduleImage: UIImage?, _ location: String, _ url1: String, _ url2: String, _ url3: String, _ category: Int, _ etc: String, _ isPublic: Bool, _ sequence: Int) {
        let email = UserDefaults.standard.string(forKey: "email")!
        let parameters: Parameters = ["email": email, "start_date": startDate, "end_date": endDate,
                                      "start_datetime": startDatetime, "end_datetime": endDatetime,
                                      "title": title, "content": content, "img_url": "asdf", "location": location,
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
