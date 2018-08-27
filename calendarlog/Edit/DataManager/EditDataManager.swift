//
//  EditDataManager.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Alamofire

class EditRemoteDataManager: EditRemoteDataManagerInputProtocol {
    var remoteRequestHandler: EditRemoteDataManagerOutputProtocol?
    
    func retrieveEditUserInfo(_ email: String) {
        let parameters: Parameters = ["email": email]
        Alamofire
            .request("\(API.baseUrl)user_info_for_edit", method: .get, parameters: parameters)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<EditUserInfoResponse>) in
                switch response.result {
                case .success(let editUserInfoResponse):
                    if editUserInfoResponse.isSuccess {
                        self.remoteRequestHandler?.didRetrieveEditUserInfo(editUserInfoResponse.sex, editUserInfoResponse.categories, editUserInfoResponse.associate)
                    } else {
                        self.remoteRequestHandler?.onError(editUserInfoResponse.message)
                    }
                case .failure:
                    self.remoteRequestHandler?.onError("네트워크 상태를 확인해주세요.")
                }
            })
    }
    
    func tryUpdateUserInfo(with userInfo: UserInfo) {
        ()
    }
}
