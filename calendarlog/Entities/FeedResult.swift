//
//  FeedResult.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 2..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import ObjectMapper

struct FeedResult {
    var isSuccess: Bool!
    var message: String!
    var feedList: [Feed]!
}

extension FeedResult: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        isSuccess <- map["isSuccess"]
        message <- map["message"]
        feedList <- map["feedList"]
    }
    
}

struct Feed {
    var email: String!
    var sequence: Int!
    var url: String!
    var nickname: String!
    var title: String!
    var content: String!
    var registerDatetime: String!
    var isPublic: String!
    var likeCount: Int!
    var isLike: String!
    var commentCount: Int!
}

extension Feed: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        email <- map["SCH_EMAIL"]
        sequence <- map["SCH_SEQ"]
        url <- map["IMG_URL"]
        nickname <- map["NICKNM"]
        title <- map["TITLE"]
        content <- map["CONTENT"]
        registerDatetime <- map["REGISTER_DATETIME"]
        isPublic <- map["IS_PUBLIC"]
        likeCount <- map["LIKE_CNT"]
        isLike <- map["IS_LIKE"]
        commentCount <- map["COM_CNT"]
    }
    
}
