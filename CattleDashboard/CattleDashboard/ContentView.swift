//
//  ContentView.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/07.
//

import SwiftUI
import Charts

struct ContentView: View {
    let cornerRadius: CGFloat = 20
    let postings = [100, 200, 300, 150, 100, 120]
    @StateObject var dataManager = HistoryDataManager()
    
    var body: some View {
        HStack(spacing: 30){
            VStack(spacing: 30) {
                Text("서울 가락시장 축산시장 경매장")
                    .font(.system(size: 40, weight: .black))
                VStack(spacing: 30){
                    VStack(spacing: 5){
                        Text("AI 등급")
                            .font(.system(size: 45, weight: .bold))
                        Text("1++")
                            .font(.system(size: 65, weight: .bold))
                    }
                    VStack(spacing: 5){
                        Text("최종 등급")
                            .font(.system(size: 45, weight: .bold))
                        Text("1++")
                            .font(.system(size: 65, weight: .bold))
                    }

                }
                .padding(50)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.gray)
                )
            }
            .padding()
            VStack {
                VStack{
                    VStack(spacing: 5){
                        Text("출하자 OOO")
                            .font(.system(size: 20, weight: .regular))
                        Image("1")
                    }
                    VStack(spacing: 5){
                        Text("최종 등급")
                            .font(.system(size: 20, weight: .regular))
                        Text("1++")
                            .font(.system(size: 20, weight: .regular))
                    }
                    
                }
            }
            VStack {
                Chart {
                    ForEach(Array(postings.enumerated()), id: \.offset) { index, posting in
                        BarMark(
                            x: .value("x",index),
                            y: .value("y", posting)
                        )
                    }
                }
                
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear() {
//            dataManager.getSearchResults(cattleNo: "410002046636437", isCattle: true)
//            dataManager.getSearchResults(cattleNo: "410002046636437", isCattle: false)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
