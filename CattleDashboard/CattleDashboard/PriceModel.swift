//
//  PriceModel.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/14.
//

import Foundation

// MARK: - PriceInfo
struct PriceInfo: Codable {
    let response: PriceResponse
}

// MARK: - Response
struct PriceResponse: Codable {
    let header: Header
    let notice: Notice
    let body: PriceBody
}

// MARK: - Body
struct PriceBody: Codable {
    let items: PriceItems
}

// MARK: - Items
struct PriceItems: Codable {
    let item: [PriceItem]
}

// MARK: - Item
struct PriceItem: Codable {
    let cCityAmt, cCityCnt, cEastAmt, cEastCnt: Int
    let cTotAmt, cTotCnt: Int
    let cWestAmt, cWestCnt: Int?
    let c0101Amt, c0101Cnt: Int?
    let c0201Amt, c0201Cnt: Int?
    let c0202Amt, c0202Cnt: Int?
    let c0302Amt, c0302Cnt, c0320Amt, c0320Cnt: Int?
    let c0323Amt, c0323Cnt: Int?
    let c0714Amt, c0714Cnt, c0809Amt, c0809Cnt: Int?
    let c0905Amt, c0905Cnt: Int?
    let c1005Amt, c1005Cnt: Int?
    let c1101Amt, c1101Cnt, c1201Amt, c1201Cnt: Int?
    let c1301Amt, c1301Cnt: Int?
    let defectIncludeYn: String
    let endYmd: Int
    let gradeCD: String
    let gradeNm: String
    let gradeType: String
    let judgeBreedCD: Int
    let judgeBreedNm: String
    let judgeSexCD: Int
    let judgeSexNm: String
    let qgradeYn: String
    let startYmd: Int

    enum CodingKeys: String, CodingKey {
        case cCityAmt = "CCityAmt"
        case cCityCnt = "CCityCnt"
        case cEastAmt = "CEastAmt"
        case cEastCnt = "CEastCnt"
        case cTotAmt = "CTotAmt"
        case cTotCnt = "CTotCnt"
        case cWestAmt = "CWestAmt"
        case cWestCnt = "CWestCnt"
        case c0101Amt = "c_0101Amt"
        case c0101Cnt = "c_0101Cnt"
        case c0201Amt = "c_0201Amt"
        case c0201Cnt = "c_0201Cnt"
        case c0202Amt = "c_0202Amt"
        case c0202Cnt = "c_0202Cnt"
        case c0302Amt = "c_0302Amt"
        case c0302Cnt = "c_0302Cnt"
        case c0320Amt = "c_0320Amt"
        case c0320Cnt = "c_0320Cnt"
        case c0323Amt = "c_0323Amt"
        case c0323Cnt = "c_0323Cnt"
        case c0714Amt = "c_0714Amt"
        case c0714Cnt = "c_0714Cnt"
        case c0809Amt = "c_0809Amt"
        case c0809Cnt = "c_0809Cnt"
        case c0905Amt = "c_0905Amt"
        case c0905Cnt = "c_0905Cnt"
        case c1005Amt = "c_1005Amt"
        case c1005Cnt = "c_1005Cnt"
        case c1101Amt = "c_1101Amt"
        case c1101Cnt = "c_1101Cnt"
        case c1201Amt = "c_1201Amt"
        case c1201Cnt = "c_1201Cnt"
        case c1301Amt = "c_1301Amt"
        case c1301Cnt = "c_1301Cnt"
        case defectIncludeYn, endYmd
        case gradeCD = "gradeCd"
        case gradeNm, gradeType
        case judgeBreedCD = "judgeBreedCd"
        case judgeBreedNm
        case judgeSexCD = "judgeSexCd"
        case judgeSexNm, qgradeYn, startYmd
    }
}
