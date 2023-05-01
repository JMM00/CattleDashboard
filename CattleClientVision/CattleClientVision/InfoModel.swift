//
//  InfoModel.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/27.
//

import Foundation

struct GradeInfo: Identifiable, Codable, Equatable, Hashable {
    var id = UUID().uuidString
    var number: String
    var aiGrade: String
    var color: String
    var fatColor: String
    var fatGrade: String
    var finalGrade: String
    var maturity: String
    var meatQuality: String
    var organization: String
    
    var dictionary: [String: Any] {
        let data = (try? JSONEncoder().encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
    }
}

struct DefaultInfo: Identifiable, Codable, Equatable, Hashable {
    var id = UUID().uuidString
    var historyNum: String
    var number: String
    var month: String
    var buying: String
    var predictedBreedingRate: String
    var totalWeight: String
    var unitPrice: String
    var bidPrice: String
    
    var dictionary: [String: Any] {
        let data = (try? JSONEncoder().encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
    }
}
