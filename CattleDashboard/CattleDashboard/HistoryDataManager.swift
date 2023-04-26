//
//  DataManager.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/07.
//

import Foundation
import XMLCoder

class HistoryDataManager: ObservableObject {
    
    @Published var entityInfo: [CattleItem] = []
    @Published var cattleEntityInfo: [CattleInfo] = []
    @Published var cattleNo = "002142700199"
    
    private let cattleHistoryKey = Bundle.main.cattleHistoryKey
    private let cattlePriceKey = Bundle.main.cattlePriceKey
    
    func getCattleResults(cattleNo: String) {
        var cattleInfo = CattleInfo(birthYmd: 0, farmAddr: "", butcheryYmd: 0, lsTypeNm: "", sexNm: "", vaccineorder: "", injectionYmd: 0, injectiondayCnt: "", inspectDt: 0, inspectYn: "")
        
        let url = "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?ServiceKey=\(cattlePriceKey)&traceNo=\(cattleNo)"
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let decoder = XMLDecoder()
                decoder.shouldProcessNamespaces = true
                let decoded = try decoder.decode(CattleResponse.self, from: data)
                print(decoded)
                decoded.body.items.item.forEach { item in
                    
                    if let birth = item.birthYmd {
                        cattleInfo.birthYmd = birth
                    }
                    if let farmAddr = item.farmAddr {
                        cattleInfo.farmAddr = farmAddr
                    }
                    if let butcheryYmd = item.butcheryYmd {
                        cattleInfo.butcheryYmd = butcheryYmd
                    }
                    if let lsTypeNm = item.lsTypeNm {
                        cattleInfo.lsTypeNm = lsTypeNm
                    }
                    if let sexNm = item.sexNm {
                        cattleInfo.sexNm = sexNm
                    }
                    if let vaccineorder = item.vaccineorder {
                        cattleInfo.vaccineorder = vaccineorder
                    }
                    if let injectionYmd = item.injectionYmd {
                        cattleInfo.injectionYmd = injectionYmd
                    }
                    if let injectiondayCnt = item.injectiondayCnt {
                        cattleInfo.injectiondayCnt = injectiondayCnt
                    }
                    if let inspectDt = item.inspectDt {
                        cattleInfo.inspectDt = inspectDt
                    }
                    if let inspectYn = item.inspectYn {
                        cattleInfo.inspectYn = inspectYn
                    }
                }
                
                self.cattleEntityInfo.append(cattleInfo)
                
            }catch(let error) {
                print(error)
            }
        }
        task.resume()
    }
}

struct CattleInfo {
    //출생일자
    var birthYmd:Int
    var farmAddr: String
    var butcheryYmd: Int
    var lsTypeNm: String
    var sexNm: String
    //구제역
    var vaccineorder: String
    var injectionYmd: Int
    var injectiondayCnt: String
    //브루셀라
    var inspectDt: Int
    var inspectYn: String
    //결핵
    var inspectDesc: String = "미검"
    
}
