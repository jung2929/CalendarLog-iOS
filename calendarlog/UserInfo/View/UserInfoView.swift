//
//  UserInfoView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class UserInfoView: SuperViewController {
    var presenter: UserInfoPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension UserInfoView: UserInfoViewProtocol {
    func initializeUI() {
        //
    }
}
