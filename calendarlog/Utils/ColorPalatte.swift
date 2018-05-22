//
//  Colors.swift
//  calendarlog
//
//  Created by JerryJung on 2018. 5. 8..
//  Copyright © 2018년 penguinexpedition. All rights reserved.
//

import UIKit

// 참고 http://zeddios.tistory.com/353 [ZeddiOS]
struct ColorPalette {
    private init() {}
    /***
     내비 기본 파란색 : 4987f7
     파란색 버튼 : 3d96ff
     파란색 글씨 : 358fff
     */
    static let Primary = UIColor(rgb: 0x4987f7)
    static let BlueForButton = UIColor(rgb: 0x3d96ff)
    static let BlueForText = UIColor(rgb: 0x358fff)
    /***
     바탕 : f9fcfe -> f6f6f6
     조금 더 진한 바탕 : f9fafe (회원가입 관심분야 밑에 배경)
     */
    static let Background = UIColor(rgb: 0xf6f6f6)
    static let BackgroundDark = UIColor(rgb: 0xf9fafe)
    /***
     주황색 : ff9b3f
     */
    static let Orange = UIColor(rgb: 0xff9b3f)
    /***
     회색글자 : 9b9b9b
     텍스트 필드 하단 라인 : dfdfdf
     기본검은글자 : 4a4a4a
     오류글자 : e25d6e
     */
    static let GrayForText = UIColor(rgb: 0x9b9b9b)
    static let GrayForBottomBorder = UIColor(rgb: 0xdfdfdf)
    static let BlackForText = UIColor(rgb: 0x4a4a4a)
    static let RedForText = UIColor(rgb: 0xe25d6e)
//    struct Gray {
//        static let Light = UIColor(white: 0.8374, alpha: 1.0)
//        static let Medium = UIColor(white: 0.4756, alpha: 1.0)
//        static let Dark = UIColor(white: 0.2605, alpha: 1.0)
//    }
}
