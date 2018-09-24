//
//  AddScheduleRemoteDataManager.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Alamofire

class AddScheduleRemoteDataManager: AddScheduleRemoteDataManagerInputProtocol {
    var remoteRequestHandler: AddScheduleRemoteDataManagerOutputProtocol?
    
    func tryCreateSchedule(_ parameters: Parameters) {
        Alamofire
            .request("\(API.baseUrl)create_schedule", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<DefaultResponse>) in
                switch response.result {
                case .success(let defaultResponse):
                    if defaultResponse.isSuccess {
                        self.remoteRequestHandler?.didCreateOrUpdateSchedule()
                    } else {
                        self.remoteRequestHandler?.onError(with: defaultResponse.message)
                    }
                case .failure:
                    self.remoteRequestHandler?.onError(with: "스케줄 등록에 실패하였습니다.")
                }
            })
    }
    
    func tryUpdateSchedule(_ parameters: Parameters) {
        Alamofire
            .request("\(API.baseUrl)update_schedule", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<DefaultResponse>) in
                switch response.result {
                case .success(let defaultResponse):
                    if defaultResponse.isSuccess {
                        self.remoteRequestHandler?.didCreateOrUpdateSchedule()
                    } else {
                        self.remoteRequestHandler?.onError(with: defaultResponse.message)
                    }
                case .failure:
                    self.remoteRequestHandler?.onError(with: "스케줄 수정에 실패하였습니다.")
                }
            })
    }
}
