//
//  FeedResponse.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 2..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import ObjectMapper

struct FeedResponse {
    var isSuccess: Bool!
    var message: String!
    var feedList: [Feed]!
}

extension FeedResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        isSuccess <- map["isSuccess"]
        message <- map["message"]
        feedList <- map["feedList"]
    }
    
}

struct Feed {
    var scheduleEmail: String!
    var scheduleSequence: Int!
    var scheduleImageUrl: String!
    var nickname: String!
    var title: String!
    var content: String!
    var endDatetimeText: String!
    var isPublic: String!
    var likeCount: Int!
    var isLike: String!
    var commentCount: Int!
    var startDatetime: String!
    var endDatetime: String!
    var location: String!
    var categoryIndex: String!
    var url1: String!
    var url2: String!
    var url3: String!
}

extension Feed: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        scheduleEmail <- map["SCH_EMAIL"]
        scheduleSequence <- map["SCH_SEQ"]
        scheduleImageUrl <- map["IMG_URL"]
        nickname <- map["NICKNM"]
        title <- map["TITLE"]
        content <- map["CONTENT"]
        endDatetimeText <- map["END_DATETIME_TEXT"]
        isPublic <- map["IS_PUBLIC"]
        likeCount <- map["LIKE_CNT"]
        isLike <- map["IS_LIKE"]
        commentCount <- map["COM_CNT"]
        startDatetime <- map["START_DATETIME"]
        endDatetime <- map["END_DATETIME"]
        location <- map["LOCATION"]
        categoryIndex <- map["CTGR_IDX"]
        url1 <- map["URL_1"]
        url2 <- map["URL_2"]
        url3 <- map["URL_3"]
    }
    
}
