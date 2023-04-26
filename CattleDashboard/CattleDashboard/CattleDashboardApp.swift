//
//  CattleDashboardApp.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/07.
//

import SwiftUI

import FirebaseCore
import FirebaseFirestore

@main
struct CattleDashboardApp: App {
    
    @StateObject var priceManager = PriceDataManager()
    @StateObject var historyManager = HistoryDataManager()
    @StateObject var infoViewModel = InfoViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environmentObject(priceManager)
                .environmentObject(historyManager)
                .environmentObject(infoViewModel)
//            TestContentView()
        }
    }
}
