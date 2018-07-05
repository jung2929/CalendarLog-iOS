//
//  NoteListView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

class NoteListView: SuperViewController {
    var presenter: NoteListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension NoteListView: NoteListViewProtocol {
    func initializeUI() {
        //
    }
}
