//
//  RegisterInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 27..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class RegisterInteractor: RegisterInteractorInputProtocol {
    weak var presenter: RegisterInteractorOutputProtocol?
    var remoteDatamanager: RegisterRemoteDataManagerInputProtocol?
    
    func validateRegister(_ email: String, _ password: String, _ passwordConfirmation: String,
                          _ nickname: String, _ sex: String, _ categoryTuples: [(Int, Int)], _ associate: String) {
        guard password.count > 5 else {
            self.presenter?.onError(with: "비밀번호는 최소 6자리 입력해주세요.")
            return
        }
        guard passwordConfirmation.count > 5 else {
            self.presenter?.onError(with: "비밀번호 확인은 최소 6자리 입력해주세요.")
            return
        }
        guard password == passwordConfirmation else {
            self.presenter?.onError(with: "비밀번호가 일치하지않습니다.")
            return
        }
        guard nickname.count > 0 else {
            self.presenter?.onError(with: "닉네임을 입력해주세요.")
            return
        }
        let filteredCategories: [Int] = categoryTuples
            .filter({ (_, value) -> Bool in
                return value == 1
            })
            .map({ (args: (Int, Int)) -> Int in
                return args.0
            })
        guard filteredCategories.count > 2 && filteredCategories.count <= 6 else {
            self.presenter?.onError(with: "카테고리는 최소 3가지 선택해주세요.")
            return
        }
        guard associate.count > 0 else {
            self.presenter?.onError(with: "단체 / 기관을 입력해주세요.")
            return
        }
        let userInfo = UserInfo(email: email, password: password, passwordConfirmation: passwordConfirmation, nickname: nickname, sex: sex, categories: filteredCategories, associate: associate)
        self.remoteDatamanager?.tryRegister(with: userInfo)
    }
}

extension RegisterInteractor: RegisterRemoteDataManagerOutputProtocol {
    func onRegisterSuccess() {
        self.presenter?.didTryRegister()
    }
    
    func onError(with message: String) {
        self.presenter?.onError(with: message)
    }
}
