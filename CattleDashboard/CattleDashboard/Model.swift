//
//  Model.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/07.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let header: Header
    let notice: Notice
    let body: Body
    
}

// MARK: - Body
struct Body: Codable {
    let items: Items
}

// MARK: - Items
struct Items: Codable {
    let item: [Item]
}

// MARK: - Item
struct Item: Codable, Hashable {
    let cattleNo, farmAddr, farmerNm, movePlace: String
    let moveYmd: String
}

struct CattleResponse: Codable {
    let header: Header
    let notice: Notice
    let body: CattleBody
    
}

struct CattleBody: Codable {
    let items: CattleItems
}

struct CattleItems: Codable {
    let item: CattleItem
}
struct CattleItem: Codable, Hashable {
    let abattCode: Int
    let birthYmd, butcheryPlaceAddr, butcheryPlaceNm: String
    let butcheryWeight: Int
    let butcheryYmd: String
    let cattleNo: Int
    let farmAddr, farmNm: String
    let farmNo: Int
    let inspectPassNm: String
    let lsTypeCD: Int
    let lsTypeNm, processPlaceNm: String
    let qgradeNm, sexCD: Int
    let sexNm, vaccineLastinjectionOrder, vaccineLastinjectionYmd: String
    
    enum CodingKeys: String, CodingKey {
        case abattCode, birthYmd, butcheryPlaceAddr, butcheryPlaceNm, butcheryWeight, butcheryYmd, cattleNo, farmAddr, farmNm, farmNo, inspectPassNm
        case lsTypeCD = "lsTypeCd"
        case lsTypeNm, processPlaceNm, qgradeNm
        case sexCD = "sexCd"
        case sexNm, vaccineLastinjectionOrder, vaccineLastinjectionYmd
    }
}

// MARK: - Header
struct Header: Codable {
    let resultCode, resultMsg: String
}

// MARK: - Notice
struct Notice: Codable {
    let rows: String
}
