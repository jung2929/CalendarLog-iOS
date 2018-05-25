//
//  LoginRemoteDataManager.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 24..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class LoginRemoteDataManager: LoginRemoteDataManagerInputProtocol {
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol?
    
    func retrieveEmail(_ email: String) {
        let parameters: Parameters = ["email": email]
        Alamofire
            .request("\(API.baseUrl)login", method: .get, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<DefaultResponse>) in
                switch response.result {
                case .success(let defaultResponse):
                    if defaultResponse.isSuccess {
                        self.remoteRequestHandler?.onLoginEmailRetrieved()
                    } else {
                        self.remoteRequestHandler?.onLoginEmailNotRetrieved()
                    }
                case .failure:
                    self.remoteRequestHandler?.onError()
                }
            })
    }
    
    func tryLogin(_ email: String, _ password: String) {
        //
        //        Alamofire
        //            .request(Endpoints.Posts.fetch.url, method: .get)
        //            .validate()
        //            .responseArray(completionHandler: { (response: DataResponse<[PostModel]>) in
        //                switch response.result {
        //                case .success(let posts):
        //                    self.remoteRequestHandler?.onPostsRetrieved(posts)
        //
        //                case .failure( _):
        //                    self.remoteRequestHandler?.onError()
        //                }
        //            })
    }
}
