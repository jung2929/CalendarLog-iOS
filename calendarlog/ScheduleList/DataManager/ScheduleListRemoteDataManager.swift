//
//  ScheduleListRemoteDataManager.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class ScheduleListRemoteDataManager: ScheduleListRemoteDataManagerInputProtocol {
    var remoteRequestHandler: ScheduleListRemoteDataManagerOutputProtocol?
    
    func retrieveFeedList(_ email: String, _ row: Int, _ scheduleDate: String) {
        let parameters: Parameters = ["email": email, "row": row, "scheduleDate": scheduleDate]
        Alamofire
            .request("\(API.baseUrl)feed_list_for_day", method: .get, parameters: parameters)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<ScheduleResponse>) in
                switch response.result {
                case .success(let scheduleResponse):
                    if scheduleResponse.isSuccess {
                        self.remoteRequestHandler?.onFeedListRetrieved(scheduleResponse.feedList, row)
                    } else {
                        self.remoteRequestHandler?.onError(scheduleResponse.message)
                    }
                case .failure:
                    self.remoteRequestHandler?.onError("네트워크 상태를 확인해주세요.")
                }
            })
    }
}
