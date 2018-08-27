//
//  EditPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import SVProgressHUD

class EditPresenter: EditPresenterProtocol {
    var view: EditViewProtocol?
    var interactor: EditInteractorInputProtocol?
    var wireframe: EditWireframeProtocol?
    
    func viewDidLoad() {
        self.view?.initializeUI()
        SVProgressHUD.show(withStatus: "계정정보를 불러오는중입니다.")
        self.interactor?.retrieveEditUserInfo()
    }
    
    func pushDone(_ email: String, _ password: String, _ passwordConfirmation: String, _ nickname: String, _ sex: String, _ categoryTuples: [(Int, Int)], _ associate: String) {
        ()
    }
}

extension EditPresenter: EditInteractorOutputProtocol {
    func didTryUpdateUserInfo() {
        ()
    }
    
    func didRetrieveEditUserInfo(_ sex: String, _ categories: [Int], _ associate: String) {
        SVProgressHUD.dismiss()
        self.view?.setEditUserInfo(sex, categories, associate)
    }
    
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
