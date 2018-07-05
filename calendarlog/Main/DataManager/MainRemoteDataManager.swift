//
//  MainRemoteDataManager.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 2..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class MainRemoteDataManager: MainRemoteDataManagerInputProtocol {
    var remoteRequestHandler: MainRemoteDataManagerOutputProtocol?
    
    func retrieveScheduleAndFeedList(_ email: String) {
        let parameters: Parameters = ["email": email]
        Alamofire
            .request("\(API.baseUrl)schedule_and_feed_list", method: .get, parameters: parameters)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<ScheduleResult>) in
                switch response.result {
                case .success(let scheduleResult):
                    if scheduleResult.isSuccess {
                        self.remoteRequestHandler?.onScheduleAndFeedListRetrieved(scheduleResult.scheduleList, scheduleResult.feedList)
                    } else {
                        self.remoteRequestHandler?.onError(scheduleResult.message)
                    }
                case .failure:
                    self.remoteRequestHandler?.onError("네트워크 상태를 확인해주세요.")
                }
            })
    }
    
    func retrieveFeedList(_ email: String, _ row: Int) {
        let parameters: Parameters = ["email": email, "row": row]
        Alamofire
            .request("\(API.baseUrl)feed_list", method: .get, parameters: parameters)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<ScheduleResult>) in
                switch response.result {
                case .success(let scheduleResult):
                    if scheduleResult.isSuccess {
                        self.remoteRequestHandler?.onFeedListRetrieved(scheduleResult.feedList)
                    } else {
                        self.remoteRequestHandler?.onError(scheduleResult.message)
                    }
                case .failure:
                    self.remoteRequestHandler?.onError("네트워크 상태를 확인해주세요.")
                }
            })
    }
}
