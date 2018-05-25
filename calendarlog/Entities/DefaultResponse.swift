//
//  DefaultResponse.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 26..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import Foundation
import ObjectMapper

struct DefaultResponse {
    var isSuccess: Bool!
    var message: String!
}

extension DefaultResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        isSuccess <- map["isSuccess"]
        message <- map["message"]
    }
    
}
