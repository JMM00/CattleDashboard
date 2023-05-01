//
//  Font+Extension.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/20.
//

import SwiftUI

extension Font {
    enum Dash {
        static var largeTitle: Font { Font.system(size: 45, weight: .bold) }
        static var title1: Font { Font.system(size: 30, weight: .semibold) }
        static var title0: Font { Font.system(size: 42, weight: .bold) }
        static var title25: Font { Font.system(size: 25, weight: .semibold) }
        static var title35: Font { Font.system(size: 35, weight: .semibold) }
        static var title30: Font { Font.system(size: 40, weight: .semibold) }
        static var title50: Font { Font.system(size: 60, weight: .bold) }
        static var title2: Font { Font.system(size: 33, weight: .semibold) }
//        static var headline2: Font { Font.system(size: 20, weight: .regular) }
//        static var body1: Font { Font.system(size: 17, weight: .medium) }
//        static var body2: Font { Font.system(size: 17, weight: .regular) }
    }
}

