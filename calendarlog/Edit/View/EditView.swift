//
//  EditView.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 22..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit
import Foundation

class EditView: SuperViewController {
    var presenter: EditPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        //내비게이션바 타이틀 설정
        self.title = "계정정보 수정"
        // 내비게이션바 우측상단 저장 이미지 설정
        let doneBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_done"), style: .done, target: self, action: #selector(self.pushDone))
        self.navigationItem.rightBarButtonItem = doneBarButtonItem
    }
}

extension EditView: EditViewProtocol {
    func initializeUI() {
        ()
    }
    
    @objc func pushDone() {
        ()
    }
    
}
