//
//  UserInfoResponse.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 24..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import ObjectMapper

struct UserInfoResponse {
    var isSuccess: Bool!
    var message: String!
    var likedScheduleCount: String!
    var nickname: String!
    var categoryTuples: [(Int, Int)]!
    var isReceiveNote: String!
    var feedList: [Feed]!
}

extension UserInfoResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        isSuccess <- map["isSuccess"]
        message <- map["message"]
        likedScheduleCount <- map["likedScheduleCount"]
        nickname <- map["nickname"]
        isReceiveNote <- map["isReceiveNote"]
        feedList <- map["feedList"]
    }
    
}
