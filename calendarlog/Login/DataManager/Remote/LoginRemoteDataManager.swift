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
            .request("\(API.baseUrl)login", method: .get, parameters: parameters)
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
                    self.remoteRequestHandler?.onError(with: "이메일 확인에 실패하였습니다.")
                }
            })
    }
    
    func tryLogin(_ email: String, _ password: String) {
        let parameters: Parameters = ["email": email, "password": password]
        Alamofire
            .request("\(API.baseUrl)login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<DefaultResponse>) in
                switch response.result {
                case .success(let defaultResponse):
                    if defaultResponse.isSuccess {
                        self.remoteRequestHandler?.onLoginSuccess()
                    } else {
                        self.remoteRequestHandler?.onError(with: defaultResponse.message)
                    }
                case .failure:
                    self.remoteRequestHandler?.onError(with: "로그인에 실패하였습니다.")
                }
            })
    }
}
