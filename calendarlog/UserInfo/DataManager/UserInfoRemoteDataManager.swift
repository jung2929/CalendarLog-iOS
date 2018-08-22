//
//  UserInfoRemoteDataManager.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Alamofire

class UserInfoRemoteDataManager: UserInfoRemoteDataManagerInputProtocol {
    var remoteRequestHandler: UserInfoRemoteDataManagerOutputProtocol?
    
    func retrieveFeedList(_ email: String, _ row: Int) {
        let parameters: Parameters = ["email": email, "row": row]
        Alamofire
            .request("\(API.baseUrl)feed_list_for_user_info", method: .get, parameters: parameters)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<FeedResponse>) in
                switch response.result {
                case .success(let feedResponse):
                    if feedResponse.isSuccess {
                        self.remoteRequestHandler?.onFeedListRetrieved(feedResponse.feedList, row, feedResponse.likedScheduleCount)
                    } else {
                        self.remoteRequestHandler?.onError(feedResponse.message)
                    }
                case .failure:
                    self.remoteRequestHandler?.onError("네트워크 상태를 확인해주세요.")
                }
            })
    }
}
