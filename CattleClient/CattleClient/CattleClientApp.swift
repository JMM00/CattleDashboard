//
//  CattleClientApp.swift
//  CattleClient
//
//  Created by 전지민 on 2023/04/07.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct CattleClientApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var mainViewcontroller = MainViewController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainViewcontroller)
        }
    }
}
