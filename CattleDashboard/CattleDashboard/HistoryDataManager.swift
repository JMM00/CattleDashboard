//
//  DataManager.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/07.
//

import Foundation
import XMLCoder

class HistoryDataManager: ObservableObject {
    @Published var moveInfo: [Item] = []
    @Published var entityInfo: [CattleItem] = []
    @Published var cattleNo = "410002046636437"
    
    private let cattleHistoryKey = Bundle.main.cattleHistoryKey
    private let cattlePriceKey = Bundle.main.cattlePriceKey
    private let serviceUrlCattle = "http://data.ekape.or.kr/openapi-data/service/user/mtrace/breeding/cattle?serviceKey="
    private let serviceUrlCattleMove = "http://data.ekape.or.kr/openapi-data/service/user/mtrace/breeding/cattleMove?serviceKey="
    
    func getSearchResults(cattleNo: String, isCattle: Bool) {
        var url = ""
        if isCattle {
            url = "http://data.ekape.or.kr/openapi-data/service/user/mtrace/breeding/cattle?serviceKey=\(cattlePriceKey)&cattleNo=\(cattleNo)"
            
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                guard let data = data else {
                    return
                }
                do {
                    let decoder = XMLDecoder()
                    decoder.shouldProcessNamespaces = true
                    let decoded = try decoder.decode(CattleResponse.self, from: data)
                    print(decoded)
                    self.entityInfo.append(decoded.body.items.item)
                }catch(let error) {
                    print(error)
                }
            }
            task.resume()
        } else {
            url = "http://data.ekape.or.kr/openapi-data/service/user/mtrace/breeding/cattleMove?serviceKey=\(cattlePriceKey)&cattleNo=\(cattleNo)"
            
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                guard let data = data else {
                    return
                }
                do {
                    let decoder = XMLDecoder()
                    decoder.shouldProcessNamespaces = true
                    let decoded = try decoder.decode(Response.self, from: data)
                    decoded.body.items.item.forEach { item in
                        self.moveInfo.append(item)
                    }
                    
                    print(decoded.body.items.item[0])
                    print(decoded.body.items.item[1])
                }catch(let error) {
                    print(error)
                }
            }
            task.resume()
        }
    }
}
