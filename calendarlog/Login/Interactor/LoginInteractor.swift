//
//  LoginInteractor.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 24..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

class LoginInteractor: LoginInteractorInputProtocol {
    weak var presenter: LoginInteractorOutputProtocol?
    var localDatamanager: LoginLocalDataManagerInputProtocol?
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol?
    
//    func retrievePostList() {
//        do {
//            if let postList = try localDatamanager?.retrievePostList() {
//                let postModelList = postList.map() {
//                    return PostModel(id: Int($0.id), title: $0.title!, imageUrl: $0.imageUrl!, thumbImageUrl: $0.thumbImageUrl!)
//                }
//                if  postModelList.isEmpty {
//                    remoteDatamanager?.retrievePostList()
//                }else{
//                    presenter?.didRetrievePosts(postModelList)
//                }
//            } else {
//                remoteDatamanager?.retrievePostList()
//            }
//
//        } catch {
//            presenter?.didRetrievePosts([])
//        }
//    }
    
}

extension LoginInteractor: LoginRemoteDataManagerOutputProtocol {
    
//    func onPostsRetrieved(_ posts: [PostModel]) {
//        presenter?.didRetrievePosts(posts)
//
//        for postModel in posts {
//            do {
//                try localDatamanager?.savePost(id: postModel.id, title: postModel.title, imageUrl: postModel.imageUrl, thumbImageUrl: postModel.thumbImageUrl)
//            } catch  {
//
//            }
//        }
//    }
    
    func onError() {
        presenter?.onError()
    }
    
}
