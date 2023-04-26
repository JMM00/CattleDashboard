//
//  PriceDataManager.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/14.
//

import Foundation
import XMLCoder

class PriceDataManager: ObservableObject {
//    1++
    @Published var priceArr_0: [Int] = []
//    1+
    @Published var priceArr_1: [Int] = []
//    1
    @Published var priceArr_2: [Int] = []
//    2
    @Published var priceArr_3: [Int] = []
//    3
    @Published var priceArr_4: [Int] = []
//    등외
    @Published var priceArr_5: [Int] = []
    
    var dateArray: [String] = []
    var sexCode = SexCode.female.rawValue
    
    private let gradePriceKey = Bundle.main.cattlePriceKey
    
    enum SexCode: Int {
        case female = 025001
        case male = 025002
        case neutrality = 025003
        case other = 025004
    }
    
    enum CowGrade: String {
        case onePP = "1++A"
        case oneP = "1+A"
        case one = "1A"
        case two = "2A"
        case three = "3A"
        case other = "등외"
    }
    
    init() {
        dateArray = getMonthDate()
    }
    
    func getMonthDate() -> [String] {
        let today = Date()
        var dateArray = [String]()
        for i in 1...37 {
            let date = Calendar.current.date(byAdding: .day, value: -i, to: today)
            dateArray.append(date?.getDate() ?? "20230401")
        }
        dateArray.insert(Date().getDate(), at: 0)
        return dateArray.reversed()
    }
    
    func getSearchResults() {
        
        for i in 0..<dateArray.count-3 {
            let url = "http://data.ekape.or.kr/openapi-data/service/user/grade/auct/cattle?ServiceKey=\(gradePriceKey)&startYmd=%20\(dateArray[i])&endYmd=\(dateArray[i+3])&breedCd=024001&sexCd=025001&qgradeYn=N&defectIncludeYn=N"
            
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                guard let data = data else {
                    return
                }
                do {
                    let decoder = XMLDecoder()
                    decoder.shouldProcessNamespaces = true
                    let decoded = try decoder.decode(PriceResponse.self, from: data)
                    
                    print(decoded)
                    decoded.body.items.item.forEach { item in
                        switch item.gradeNm {
                        case CowGrade.onePP.rawValue:
                            self.priceArr_0.append(item.cTotAmt)
                            break
                        case CowGrade.oneP.rawValue:
                            self.priceArr_1.append(item.cTotAmt)
                            break
                        case CowGrade.one.rawValue:
                            self.priceArr_2.append(item.cTotAmt)
                            break
                        case CowGrade.two.rawValue:
                            self.priceArr_3.append(item.cTotAmt)
                            break
                        case CowGrade.three.rawValue:
                            self.priceArr_4.append(item.cTotAmt)
                            break
                        case CowGrade.other.rawValue:
                            self.priceArr_5.append(item.cTotAmt)
                            break
                        default:
                            break
                        }
                    }
                    
                }catch(let error) {
                    print(error)
                }
            }
            task.resume()
        }
        dateArray.forEach { date in
            
        }
        print(priceArr_0)
    }
}
