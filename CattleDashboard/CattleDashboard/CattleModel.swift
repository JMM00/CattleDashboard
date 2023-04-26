//
//  CattleModel.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/26.
//

import Foundation

// MARK: - Cattle
struct Cattle: Codable {
    let response: CattleResponse
}

// MARK: - Response
struct CattleResponse: Codable {
    let header: Header
    let notice: Notice
    let body: CattleBody
}

// MARK: - Body
struct CattleBody: Codable {
    let items: CattleItems
}

// MARK: - Items
struct CattleItems: Codable {
    let item: [CattleItem]
}

// MARK: - Item
struct CattleItem: Codable {
    let birthYmd, cattleNo, farmNo, farmUniqueNo: Int?
    let infoType: Int
    let lsTypeNm: String?
    let monthDiff: Int?
    let sexNm: String?
    let traceNoType: String
    let farmAddr, farmerNm, regType: String?
    let regYmd: Int?
    let butcheryPlaceAddr, butcheryPlaceNm: String?
    let butcheryYmd: Int?
    let gradeNm, inspectPassYn, processPlaceAddr, processPlaceNm: String?
    let injectionYmd: Int?
    let injectiondayCnt, vaccineorder: String?
    let inspectDt: Int?
    let inspectYn: String?
}

