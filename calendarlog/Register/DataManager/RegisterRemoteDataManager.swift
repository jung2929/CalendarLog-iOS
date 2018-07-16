//
//  RegisterRemoteDataManager.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 27..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class RegisterRemoteDataManager: RegisterRemoteDataManagerInputProtocol {
    var remoteRequestHandler: RegisterRemoteDataManagerOutputProtocol?
    
    func tryRegister(with userInfo: UserInfo) {
        let parameters: Parameters = ["email": userInfo.email,
                                      "password": userInfo.password,
                                      "password_confirmation": userInfo.passwordConfirmation,
                                      "nickname": userInfo.nickname,
                                      "sex": userInfo.sex,
                                      "category": userInfo.categories,
                                      "associate": userInfo.associate]
        Alamofire
            .request("\(API.baseUrl)register", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<DefaultResponse>) in
                switch response.result {
                case .success(let defaultResponse):
                    if defaultResponse.isSuccess {
                        self.remoteRequestHandler?.onRegisterSuccess(userInfo.email, userInfo.password)
                    } else {
                        self.remoteRequestHandler?.onError(with: defaultResponse.message)
                    }
                case .failure:
                    self.remoteRequestHandler?.onError(with: "회원가입에 실패하였습니다.")
                }
            })
    }
}
