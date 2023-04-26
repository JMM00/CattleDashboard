//
//  DashboardView.swift
//  CattleDashboard
//
//  Created by 전지민 on 2023/04/10.
//

import SwiftUI
import Charts
import SwiftPieChart

struct DashboardView: View {
    
    @EnvironmentObject var priceManager: PriceDataManager
    @EnvironmentObject var historyManager: HistoryDataManager
    @EnvironmentObject var infoViewModel: InfoViewModel
    
    let data: [(Double, Color)] = [
                (128, .chart2)
            ]
    
    var body: some View {
        GeometryReader { screen in
            VStack(spacing: 10) {
                HStack {
                    VStack{
                        HStack(spacing: 20) {
                            Text("대전충남양돈농협")
                                .font(.Dash.title1)
                            Image("NH")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35)
                            Text("포크빌 축산물 공판장")
                                .font(.Dash.largeTitle)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.border, lineWidth: 4)
                            ))
                        .padding(.horizontal, 10)
                        .padding(.top, 20)
                        
                        HStack{
                            ZStack (alignment: .bottomTrailing){
                                Image("1")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .scaleEffect(1.3)
                                Image("selected")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                                    .padding(.bottom, -40)
                            }
                            .frame(width: 350, height: 350)
                            DefaultInfoView(screen: screen.size)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                    }
                    VStack(alignment: .leading, spacing: 7){
                        Text("30일간 시세")
                            .font(.Dash.title1)
                            .padding(.vertical, 6)
                            .frame(width: 200)
                            .background(RoundedRectangle(cornerRadius: 50)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .strokeBorder(Color.border, lineWidth: 2)
                                ))
                        ChartView(screen: screen.size, postings: priceManager.priceArr_0)
                        Text("7일간 시세")
                            .font(.Dash.title1)
                            .padding(.vertical, 6)
                            .frame(width: 200)
                            .background(RoundedRectangle(cornerRadius: 50)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .strokeBorder(Color.border, lineWidth: 2)
                                ))
                        ChartView_week(screen: screen.size, postings: priceManager.priceArr_0)
                    }
                    .onAppear() {
//                        priceManager.getSearchResults()
                        historyManager.getCattleResults(cattleNo: "002142700199")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 34)
                    .padding(.vertical, 30)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.componentBg)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.border, lineWidth: 4)
                        ))
                    
                }
                
                HStack {
                    GradeView(screen: screen.size)
                    
                    GradeInfoView(screen: screen.size)
                    
                    HistoryView()
                    
                    VStack(alignment: .center) {
                        HStack {
                            Text("경매진행률")
                                .font(.Dash.title2)
                                .padding(.horizontal, 9)
                                .padding(.vertical, 3)
                                .background(RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .strokeBorder(Color.border, lineWidth: 2)
                                    ))
                            Spacer()
                            Text("42.5%")
                                .font(.Dash.title0)
                                .foregroundColor(.systemBlue)
                            Spacer()
                        }
                        .padding(.vertical, 5)
                        ZStack(alignment: .center) {
                            Circle().foregroundColor(.chart1)
                            ProgressView(screen: screen.size, slices: data)
                        }
                        .padding(.top, 20)
                        Text(Date().getTime())
                            .font(.Dash.title25)
                            .foregroundColor(.red)
                            .padding(7)
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.border, lineWidth: 4)
                                ))
                            .padding()
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 20)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.componentBg)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.border, lineWidth: 4)
                        ))
                }
                .background(Color.red)
                .padding(.bottom, 20)
            }
            .padding(20)
        }
        .background(Color.background)
    }
}

struct HistoryView: View {
    @EnvironmentObject var historyManager: HistoryDataManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("축산물 이력")
                .font(.Dash.title1)
                .padding(.vertical, 10)
                .padding(.horizontal, 13)
                .background(RoundedRectangle(cornerRadius: 50)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .strokeBorder(Color.border, lineWidth: 2)
                    ))
            HStack {
                Image("birth")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75)
                Spacer()
                VStack {
                    if historyManager.cattleEntityInfo.count != 0 {
                        Text("출생")
                        Text(String(historyManager.cattleEntityInfo[0].birthYmd))
                            .foregroundColor(.systemBlue)
                        Text(historyManager.cattleEntityInfo[0].farmAddr)
                            .foregroundColor(.systemBlue)
                    }
                }
                .onAppear() {
                    print(historyManager.entityInfo.count)
                }
                Spacer()
            }
            
            HStack {
                Image("cut")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75)
                Spacer()
                if historyManager.cattleEntityInfo.count != 0 {
                    VStack {
                        Text("도축일자")
                        Text(String(historyManager.cattleEntityInfo[0].butcheryYmd))
                            .foregroundColor(.systemBlue)
                    }
                    Spacer()
                }
            }
            
            HStack {
                Image("Vaccination")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75)
                
                Spacer()
                
                if historyManager.cattleEntityInfo.count != 0 {
                    HStack(spacing: 20){
                        VStack {
                            Text("구제역")
                            Text(historyManager.cattleEntityInfo[0].vaccineorder)
                                .foregroundColor(.systemBlue)
                        }
                        VStack {
                            Text("결핵")
                            Text(historyManager.cattleEntityInfo[0].inspectDesc)
                                .foregroundColor(.systemBlue)
                        }
                        VStack {
                            Text("브루셀라")
                            Text(historyManager.cattleEntityInfo[0].inspectYn)
                                .foregroundColor(.systemBlue)
                        }
                    }
                }
                Spacer()
            }
        }
        .padding()
        .font(.Dash.title1)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(Color.componentBg)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.border, lineWidth: 4)
            ))
    }
}

struct DefaultInfoView: View {
    @EnvironmentObject var historyManager: HistoryDataManager
    @EnvironmentObject var infoViewModel: InfoViewModel
    let screen: CGSize
    
    var body: some View {
        VStack(spacing: 8) {
            Text("도체 기본정보")
                .font(.Dash.title1)
                .padding(3)
                .padding(.horizontal, 40)
                .background(RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .strokeBorder(Color.border, lineWidth: 2)
                    ))
                .padding(8)
            if infoViewModel.defaultInfo.count != 0 {
                VStack {
                    DefaultViewCell(title: "지육번호", content: infoViewModel.defaultInfo[0].number, type: .number)
                    DefaultViewCell(title: "품종", content: historyManager.cattleEntityInfo[0].lsTypeNm, type: .other)
                    DefaultViewCell(title: "성별", content: historyManager.cattleEntityInfo[0].sexNm, type: .other)
                    DefaultViewCell(title: "개월령", content: infoViewModel.defaultInfo[0].month, type: .month)
                    DefaultViewCell(title: "총중량", content: infoViewModel.defaultInfo[0].totalWeight, type: .kg)
                    DefaultViewCell(title: "예측정육률", content: infoViewModel.defaultInfo[0].predictedBreedingRate, type: .percent)
                    DefaultViewCell(title: "단가", content: infoViewModel.defaultInfo[0].unitPrice, type: .pricePerKg)
                    DefaultViewCell(title: "매수", content: infoViewModel.defaultInfo[0].buying, type: .other)
                }
                .padding(.leading, 20)
                .padding(.vertical, 10)
            }
        }
        .padding(.vertical, 5)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(Color.componentBg)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.border, lineWidth: 4)
            ))
        .frame(maxWidth: screen.width/4)
    }
}



enum DefaultInfoType {
    case number
    case month
    case kg
    case percent
    case pricePerKg
    case other
}

struct DefaultViewCell: View {
    let title: String
    var content: String
    let type: DefaultInfoType
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .frame(width: 110, alignment: .leading)
            Spacer()
            Text(content)
                .foregroundColor(.systemBlue)
            switch type{
            case DefaultInfoType.number:
                Text("번")
                    .foregroundColor(.systemBlue)
            case DefaultInfoType.month:
                Text("개월")
            case DefaultInfoType.kg:
                Text("kg")
            case DefaultInfoType.percent:
                Text("%")
            case DefaultInfoType.pricePerKg:
                Text("원/kg")
            case DefaultInfoType.other:
                Text("")
            }
        }
        .font(.Dash.title1)
        .padding(.trailing, 20)
    }
}

struct GradeCell: View {
    let title: String
    var content: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.vertical, 11)
                .frame(width: 120)
                .font(.Dash.title1)
                .background(RoundedRectangle(cornerRadius: 50)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .strokeBorder(Color.border, lineWidth: 3)
                    ))
            Spacer()
            Text(content)
                .font(.Dash.title0)
                .foregroundColor(.systemBlue)
            Spacer()
        }
        
    }
}

struct GradeView: View {
    @EnvironmentObject var infoViewModel: InfoViewModel
    
    var screen: CGSize
    let price = 32750
    var body: some View {
        
        VStack(spacing: 12) {
            HStack {
                Text("이력번호")
                Spacer()
                if infoViewModel.defaultInfo.count != 0 {
                    Text(infoViewModel.defaultInfo[0].historyNum)
                        .foregroundColor(.systemBlue)
                        .padding(.trailing, 20)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            .font(.Dash.title25)
            .background(RoundedRectangle(cornerRadius: 50)
                .fill(Color.componentBg)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .strokeBorder(Color.border, lineWidth: 1)
                ))
            
            HStack {
                Text("낙찰단가")
                    .padding(.vertical, 10)
                    .frame(width: 122)
                    .font(.Dash.title25)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.border, lineWidth: 4)
                        ))
                Spacer()
                if !infoViewModel.defaultInfo.isEmpty {
                    Text("\(infoViewModel.defaultInfo[0].bidPrice)/kg")
                        .font(.Dash.title30)
                        .foregroundColor(.systemBlue)
                    Spacer()
                }
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 25)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color.componentBg)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.border, lineWidth: 4)
                ))
            
            VStack {
                Divider()
                    .padding(.top, 22)
                HStack {
                    Text("AI 등급")
                        .padding(.vertical, 10)
                        .frame(width: 122)
                        .font(.Dash.title30)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.border, lineWidth: 4)
                            ))
                    Spacer()
                    if !infoViewModel.gradeInfo.isEmpty {
                        Text(infoViewModel.gradeInfo[0].aiGrade)
                            .foregroundColor(.systemBlue)
                            .font(.Dash.title50)
                        Spacer()
                    }
                }
                HStack {
                    Text("최종등급")
                        .padding(.vertical, 10)
                        .frame(width: 122)
                        .font(.Dash.title30)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.border, lineWidth: 4)
                            ))
                    Spacer()
                    if !infoViewModel.gradeInfo.isEmpty {
                        Text(infoViewModel.gradeInfo[0].finalGrade)
                            .foregroundColor(.systemBlue)
                            .font(.Dash.title50)
                        Spacer()
                    }
                }
                
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 25)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color.componentBg)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.border, lineWidth: 4)
                ))
        }
        .frame(width: screen.width/4)
    }
}

struct GradeInfoView: View {
    @EnvironmentObject var infoViewModel: InfoViewModel
    var screen: CGSize
    var body: some View {
        if !infoViewModel.gradeInfo.isEmpty {
            VStack(spacing: 5) {
                GradeCell(title: "육질등급", content: infoViewModel.gradeInfo[0].meatQuality)
                GradeCell(title: "근내지방도", content: infoViewModel.gradeInfo[0].fatGrade)
                GradeCell(title: "육색", content: infoViewModel.gradeInfo[0].color)
                GradeCell(title: "지방색", content: infoViewModel.gradeInfo[0].fatColor)
                GradeCell(title: "조직감", content: infoViewModel.gradeInfo[0].organization)
                GradeCell(title: "성숙도", content: infoViewModel.gradeInfo[0].maturity)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color.componentBg)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.border, lineWidth: 4)
                ))
            .frame(maxWidth: screen.width/4)
        }
    }
}

struct ChartView: View {
    var screen: CGSize
    let postings: [Int]
    let tests = [10000, 15000, 19000, 8000, 40000, 30000]
    
    var body: some View {
        Chart {
            ForEach(Array(tests.enumerated()), id: \.offset) { index, posting in
                LineMark(
                    x: .value("x",index),
                    y: .value("y", posting)
                )
            }
        }
        .foregroundStyle(.red)
        .chartYScale(domain: (tests.min() ?? 10000)...(tests.max() ?? 40000))
//        .chartYScale(domain: (postings.min() ?? 10000)...(postings.max() ?? 40000))
    }
}

struct ChartView_week: View {
    var screen: CGSize
    let postings: [Int]
    let tests = [10000, 15000, 19000, 8000, 50000, 30000]
    
    var body: some View {
        Chart {
            ForEach(Array(tests.enumerated()), id: \.offset) { index, posting in
                if index < 7 {
                    LineMark(
                        x: .value("x",index),
                        y: .value("y", posting)
                    )
                }
            }
        }
        .foregroundStyle(.blue)
        .chartYScale(domain: (tests.min() ?? 10000)...(tests.max() ?? 40000))
//        .chartYScale(domain: (postings.min() ?? 10000)...(postings.max() ?? 40000))
    }
}

struct ProgressView: View {
    var screen: CGSize
    @State var slices: [(Double, Color)]
    
    var body: some View {
        Canvas { context, size in
//            let total = slices.reduce(0) { $0 + $1.0 }
            let total:Double = 300.0
            context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
            var pieContext = context
            pieContext.rotate(by: .degrees(-90))
            let radius = min(size.width, size.height) * 0.5
            var startAngle = Angle.zero
            
            let angle = Angle(degrees: 360 * (slices[0].0 / total))
            let endAngle = startAngle + angle
            let path = Path { p in
                p.move(to: .zero)
                p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                p.closeSubpath()
            }
            pieContext.fill(path, with: .color(slices[0].1))
        }
        .aspectRatio(1, contentMode: .fit)
        .scaleEffect(1.2)
    }
}
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
