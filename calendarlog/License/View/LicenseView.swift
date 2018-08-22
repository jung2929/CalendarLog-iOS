//
//  LicenseView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class LicenseView: SuperViewController {
    var presenter: LicensePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension LicenseView: LicenseViewProtocol {
    func initializeUI() {
        ()
    }
}
