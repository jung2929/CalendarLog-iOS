//
//  UserInfoWireframe.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class UserInfoWireframe: UserInfoWireframeProtocol {
    static func createUserInfoModule() -> UserInfoView {
        let view = UserInfoView()
        let presenter: UserInfoPresenterProtocol & UserInfoInteractorOutputProtocol = UserInfoPresenter()
        let interactor: UserInfoInteractorInputProtocol & UserInfoRemoteDataManagerOutputProtocol = UserInfoInteractor()
        let remoteDataManager: UserInfoRemoteDataManagerInputProtocol = UserInfoRemoteDataManager()
        let wireframe: UserInfoWireframeProtocol = UserInfoWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
}
