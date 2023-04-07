//
//  Bundle+Extension.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/07.
//

import Foundation

extension Bundle {
    
    var cattlePriceKey: String {
        // forResource에다 plist 파일 이름을 입력해주세요.
        guard let filePath = Bundle.main.path(forResource: "APIServiceKey", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file 'APIServiceKey.plist'.")
        }
        
        // plist 안쪽에 사용할 Key값을 입력해주세요.
        guard let cattlePriceValue = plistDict.object(forKey: "cattlePriceServiceKey") as? String else {
            fatalError("Couldn't find key 'API_Key' in 'SecureAPIKeys.plist'.")
        }
        return cattlePriceValue
    }
    
    var cattleHistoryKey: String {
        // forResource에다 plist 파일 이름을 입력해주세요.
        guard let filePath = Bundle.main.path(forResource: "APIServiceKey", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file 'APIServiceKey.plist'.")
        }
        guard let cattleHistoryValue = plistDict.object(forKey: "cattleHistoryServiceKey") as? String else {
            fatalError("Couldn't find key 'API_Key' in 'SecureAPIKeys.plist'.")
        }
        return cattleHistoryValue
    }
}
