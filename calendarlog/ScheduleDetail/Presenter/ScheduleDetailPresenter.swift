//
//  ScheduleDetailPresenter.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 5..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import SVProgressHUD

class ScheduleDetailPresenter: ScheduleDetailPresenterProtocol {
    var view: ScheduleDetailViewProtocol?
    var interactor: ScheduleDetailInteractorInputProtocol?
    var wireframe: ScheduleDetailWireframeProtocol?
    
    func viewDidLoad() {
        self.view?.initializeUI()
    }
    
    func viewWillAppear(_ scheduleEmail: String, _ scheduleSequence: Int) {
        SVProgressHUD.show(withStatus: "일정 및 댓글내역을 불러오는중입니다.")
        self.view?.loadScheduleDetail()
        self.interactor?.retrieveCommentList(scheduleEmail, scheduleSequence)
    }

    func createComment(_ scheduleEmail: String, _ scheduleSequence: Int, _ content: String) {
        SVProgressHUD.show(withStatus: "댓글을 작성 중입니다.")
        self.interactor?.createComment(scheduleEmail, scheduleSequence, content)
    }
    
    func presentScheduleForEdit() {
        ()
    }
}

extension ScheduleDetailPresenter: ScheduleDetailInteractorOutputProtocol {
    func didRetrieveCommentList(_ commentList: [Comment]) {
        self.view?.commentList = commentList
        self.view?.loadCommentList()
        SVProgressHUD.dismiss()
    }
    
    func didCreateComment(_ comment: Comment) {
        if self.view?.commentList == nil {
            self.view?.commentList = [comment]
        } else {
            self.view?.commentList = [comment] + self.view!.commentList!
        }
        self.view?.addCommentToList()
        SVProgressHUD.dismiss()
    }
    
    func onError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
