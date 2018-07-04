//
//  ScheduleResult.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 7. 2..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import ObjectMapper

struct ScheduleResult {
    var isSuccess: Bool!
    var message: String!
    var scheduleList: [Schedule]!
    var feedList: [Feed]!
}

extension ScheduleResult: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        isSuccess <- map["isSuccess"]
        message <- map["message"]
        scheduleList <- map["scheduleList"]
        feedList <- map["feedList"]
    }
    
}

struct Schedule {
    var scheduleDate: String!
    var scheduleCount: Int!
}

extension Schedule: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        scheduleDate <- map["SCH_DATE"]
        scheduleCount <- map["SCH_CNT"]
    }
    
}
