//
//  SettingsDataManager.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Alamofire

class SettingsRemoteDataManager: SettingsRemoteDataManagerInputProtocol {
    var remoteRequestHandler: SettingsRemoteDataManagerOutputProtocol?
    
    func tryUpdateNoteStatus(_ email: String, _ isReceiveNote: Bool) {
        let parameters: Parameters = ["email": email, "isReceiveNote": isReceiveNote]
        Alamofire
            .request("\(API.baseUrl)update_note_status", method: .put, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<DefaultResponse>) in
                switch response.result {
                case .success(let defaultResponse):
                    if defaultResponse.isSuccess {
                        self.remoteRequestHandler?.onUpdateNoteStatus(isReceiveNote)
                    } else {
                        self.remoteRequestHandler?.onError(defaultResponse.message)
                    }
                case .failure:
                    self.remoteRequestHandler?.onError("쪽지 수신 변경에 실패하였습니다.")
                }
            })
    }
    
    func tryDeleteUserInfo(_ email: String) {
        let parameters: Parameters = ["email": email]
        Alamofire
            .request("\(API.baseUrl)delete_user_info", method: .delete, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<DefaultResponse>) in
                switch response.result {
                case .success(let defaultResponse):
                    if defaultResponse.isSuccess {
                        self.remoteRequestHandler?.onDeleteUserInfoSuccess()
                    } else {
                        self.remoteRequestHandler?.onError(defaultResponse.message)
                    }
                case .failure:
                    self.remoteRequestHandler?.onError("회원탈퇴에 실패하였습니다.")
                }
            })
    }
}
