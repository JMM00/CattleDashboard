//
//  InfoViewModel.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/27.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import XMLCoder

class InfoViewModel: ObservableObject {
    @Published var entityInfo: [CattleItem] = []
    @Published var cattleEntityInfo: [CattleInfo] = []
    @Published var cattleNo = "002142700199"
    
    private let cattleHistoryKey = Bundle.main.cattleHistoryKey
    private let cattlePriceKey = Bundle.main.cattlePriceKey
    
    @Published var gradeInfo: [GradeInfo] = []
    @Published var defaultInfo: [DefaultInfo] = []
    
    var index = 0
    private let db = Firestore.firestore()
    
    init() {
        fetchGradeAll { gradeInfo in
            self.gradeInfo = gradeInfo
            print(gradeInfo)
        }
        fetchDefaultAll { defaultInfo in
            self.defaultInfo = defaultInfo
            self.cattleNo = defaultInfo[self.index].historyNum
            self.getCattleResults(cattleNo: self.cattleNo)
            print(defaultInfo)
        }
        
    }
    
    func fetchGradeAll(
        completionHandler: @escaping ([GradeInfo])->()) {
            
            var gradeInfo: [GradeInfo] = []
            var query: Query!
            
            query = db.collection("GradeInfo").order(by: "number", descending: false)
            
            query.addSnapshotListener { snapshot, error in
                guard let snapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    let decoder = JSONDecoder()
                    
                    do {
                        let data = diff.document.data()
                        let jsonData = try JSONSerialization.data(withJSONObject: data)
                        let grade = try decoder.decode(GradeInfo.self, from: jsonData)
                        
                        if (diff.type == .added) {
                            gradeInfo.insert(grade, at: 0)
                            self.gradeInfo.append(grade)
                        }
                    } catch let error {
                        print("error: \(error)")
                    }
                }
                completionHandler(gradeInfo)
            }
        }
    
    func fetchDefaultAll(
        completionHandler: @escaping ([DefaultInfo])->()) {
            
            var defaultInfo: [DefaultInfo] = []
            var query: Query!
            
            query = db.collection("defaultInfo").order(by: "number", descending: false)
            
            query.addSnapshotListener { snapshot, error in
                guard let snapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    let decoder = JSONDecoder()
                    
                    do {
                        let data = diff.document.data()
                        let jsonData = try JSONSerialization.data(withJSONObject: data)
                        let defaultData = try decoder.decode(DefaultInfo.self, from: jsonData)
                        
                        if (diff.type == .added) {
                            defaultInfo.insert(defaultData, at: 0)
                            self.defaultInfo.append(defaultData)
                        }
                    } catch let error {
                        print("error: \(error)")
                    }
                }
                completionHandler(defaultInfo)
            }
        }
    
    
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
