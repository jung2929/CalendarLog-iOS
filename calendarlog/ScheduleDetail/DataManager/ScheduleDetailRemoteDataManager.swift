//
//  ScheduleDetailRemoteDataManager.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Alamofire

class ScheduleDetailRemoteDataManager: ScheduleDetailRemoteDataManagerInputProtocol {
    var remoteRequestHandler: ScheduleDetailRemoteDataManagerOutputProtocol?
    
    func retrieveCommentList(_ scheduleEmail: String, _ scheduleSequence: Int) {
        let parameters: Parameters = ["scheduleEmail": scheduleEmail, "scheduleSequence": scheduleSequence]
        Alamofire
            .request("\(API.baseUrl)comment_list", method: .get, parameters: parameters)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<CommentResponse>) in
                switch response.result {
                case .success(let commentResponse):
                    if commentResponse.isSuccess {
                        self.remoteRequestHandler?.onCommentListRetrieved(commentResponse.commentList)
                    } else {
                        self.remoteRequestHandler?.onError(commentResponse.message)
                    }
                case .failure:
                    self.remoteRequestHandler?.onError("네트워크 상태를 확인해주세요.")
                }
            })
    }
    
    func tryCreateComment(_ scheduleEmail: String, _ scheduleSequence: Int, _ email: String, _ content: String) {
        let parameters: Parameters = ["scheduleEmail": scheduleEmail, "scheduleSequence": scheduleSequence, "email": email, "content": content]
        Alamofire
            .request("\(API.baseUrl)create_comment", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<CommentResponse>) in
                switch response.result {
                case .success(let commentResponse):
                    if commentResponse.isSuccess {
                        self.remoteRequestHandler?.onCommentCreated(commentResponse.commentList[0])
                    } else {
                        self.remoteRequestHandler?.onError(commentResponse.message)
                    }
                case .failure:
                    self.remoteRequestHandler?.onError("네트워크 상태를 확인해주세요.")
                }
            })
    }
}
