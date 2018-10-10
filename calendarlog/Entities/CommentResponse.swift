//
//  CommentResponse.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 10. 10..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import ObjectMapper

struct CommentResponse {
    var isSuccess: Bool!
    var message: String!
    var commentList: [Comment]!
}

extension CommentResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        isSuccess <- map["isSuccess"]
        message <- map["message"]
        commentList <- map["commentList"]
    }
    
}

struct Comment {
    var nickname: String!
    var content: String!
    var registerDatetime: String!
}

extension Comment: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        nickname <- map["NICKNM"]
        content <- map["CONTENT"]
        registerDatetime <- map["REGISTER_DATETIME"]
    }
    
}
