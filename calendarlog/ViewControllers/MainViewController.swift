//
//  MainViewController.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 23..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit
import FSCalendar

class MainViewController: SuperViewController, FSCalendarDataSource, FSCalendarDelegate {
    fileprivate weak var calendar: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
    }
}
