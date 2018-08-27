//
//  EditUserInfoResponse.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 8. 28..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import ObjectMapper

struct EditUserInfoResponse {
    var isSuccess: Bool!
    var message: String!
    var sex: String!
    var categories: [Int]!
    var associate: String!
}

extension EditUserInfoResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        isSuccess <- map["isSuccess"]
        message <- map["message"]
        sex <- map["sex"]
        categories <- map["categories"]
        associate <- map["associate"]
    }
    
}
