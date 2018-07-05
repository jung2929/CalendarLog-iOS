//
//  ScheduleDetailView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class ScheduleDetailView: SuperViewController {
    var presenter: ScheduleDetailPresenterProtocol?
    var feedValue: Feed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension ScheduleDetailView: ScheduleDetailViewProtocol {
    func initializeUI() {
        //
    }
}
