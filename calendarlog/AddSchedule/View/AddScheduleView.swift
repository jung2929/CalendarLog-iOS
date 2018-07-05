//
//  AddScheduleView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class AddScheduleView: SuperViewController {
    var presenter: AddSchedulePresenterProtocol?
    var dateValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension AddScheduleView: AddScheduleViewProtocol {
    func initializeUI() {
        //
    }
}
