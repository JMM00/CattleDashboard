//
//  Date+Extension.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/20.
//

import Foundation

extension Date {
    
    /// Date를 yyyyMMdd 형태의 String으로 변환해주는 함수입니다.
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyyMMdd"
        
        return formatter.string(from: self)
    }
    func getTime() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yy.MM.dd. HH:mm:ss"
        
        return formatter.string(from: self)
    }
}
