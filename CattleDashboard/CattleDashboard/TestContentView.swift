//
//  TestContentView.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/14.
//

import SwiftUI

struct TestContentView: View {
    @StateObject var priceDataManager = PriceDataManager()
    var body: some View {
        
        List {
            Text("\(priceDataManager.priceArr_0.count)")
            ForEach(Array(priceDataManager.priceArr_0.enumerated()), id: \.offset) { index, priceItem in
//
//                Text("priceItem\(index)")
                Text("\(index) gradeNm \n\(priceItem)")
//                Text(priceItem.auctAmt)
            }
        }
        .onAppear() {
            priceDataManager.getSearchResults()
        }
    }
}

struct TestContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestContentView()
    }
}
