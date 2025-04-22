//
//  Untitled 2.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/16/25.
//
import SwiftUI
import Foundation

let isPreviewMode: Bool = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" // navigation으로 화면 이동시 crash 방지

struct DateFormatterHelper {
    static func formattedDateWithSuffix(_ date: Date) -> String {
        let day = Calendar.current.component(.day, from: date)
        let suffix: String
        
        switch day {
        case 1, 21, 31: suffix = "st"
        case 2, 22: suffix = "nd"
        case 3, 23: suffix = "rd"
        default: suffix = "th"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        let month = formatter.string(from: date)
        
        return "\(month) \(day)\(suffix)"
    }
}

struct DetailView: View {
    let date: Date
    
    @EnvironmentObject var mistakeManager: MistakeManager
    
    var mistake: Mistake? {
        mistakeManager.mistakes.first { Calendar.current.isDate($0.date, inSameDayAs: date) }
    } // calview에서 날짜를 누르면 그날 저장한 데이터를 불러온다
    
    @State private var goToCalView = false
    @State private var navigateToWritingView = false
    //navigation 연결 장치
    
    var body: some View {
        
        ZStack{
            Image("bkgr")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Spacer()
                DetailLayer( // struct DetailLayer: View { 를 불러옴
                    date: date,
                    mistake: mistake
                )
                
                HStack {
                    Spacer()
                    
                    Button {
                        if let mistake = mistake {
                            mistakeManager.mistakes.removeAll { $0.id == mistake.id }
                            goToCalView = true
                        }
                    } label: {
                        Image(systemName: "trash") // preview crash 일어남 고쳐야함
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.trailing, 30)
                    }
                }
                .padding(.top, 5)
                
                Spacer()
                
                Button {
                    if !isPreviewMode {
                        goToCalView = true
                    }
                } label: {
                    Image("확인")
                        .resizable()
                        .frame(width: 261, height: 50)
                        .padding(.bottom, 30)
                }
                .navigationDestination(isPresented: $goToCalView) {
                    CalView()
                }
            }
            
        }
    }
}

struct DetailLayer: View {
    var date: Date
    var mistake: Mistake? // 실수 입력 안한 날도 있으므로
    
    var body: some View {
        VStack {
            ZStack {
                Text("")
                    .frame(width: 360, height: 100)
                    .background(Color("리드핑크"))
                    .cornerRadius(15)
                    .padding(.top,20)
                
                HStack {
                    Text(DateFormatterHelper.formattedDateWithSuffix(date))
                        .font(.custom("EF_jejudoldam", size: 18))
                        .frame(width: 75, height: 75)
                        .background(Color("핑크"))
                        .cornerRadius(20)
                        .padding(.leading, 40)
                        .padding(.top,18)
                    
                    Spacer()
                    
                    if let mistake, let weather = WeatherType(rawValue: mistake.result) { //옵셔널 바인딩 2번. 실수 있는지 확인--> 해당하는 날씨 있는지 확인
                        Image(weather.afterSelect())
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                            .padding(.leading, 10)
                            .padding(.top,22)
                    }
                    
                    Spacer()
                    
                    if let mistake, let fruit = FruitType(rawValue: mistake.feeling) {
                        Image(fruit.afterSelect())
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                            .padding(.trailing,40)
                            .padding(.top,20)
                    }
                }
                Spacer()
            }
            
            if let mistake = mistake {
                Text(mistake.text)
                    .font(.custom("EF_jejudoldam", size: 20))
                    .minimumScaleFactor(0.5)
                    .lineLimit(3)
                    .frame(width: 360, height: 100)
                    .background(Color("리드핑크"))
                    .cornerRadius(12)
                    .padding()
            }
            
            ZStack {
                Text("")
                    .frame(width: 360, height: 400)
                    .background(Color("리드핑크"))
                    .cornerRadius(12)
                
                VStack {
                    Text(mistake?.peachName ?? "")
                        .font(.custom("EF_jejudoldam", size: 25))
                        .frame(width: 200, height: 60)
                        .background(Color("핑크"))
                        .cornerRadius(12)
                        .padding(.top, 10)
                    
                    Text(mistake?.peachDescription ?? "")
                        .font(.custom("EF_jejudoldam", size: 15))
                        .frame(width: 350, height: 100)
                        .cornerRadius(12)
                        .padding()
                    
                    (mistake?.peachImage ?? Image("오늘의 복숭아"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .cornerRadius(15)
                        .padding(.bottom, 10)
                }
            }
        }
    }
}

#Preview {
    let exampleDate = Calendar.current.date(from: DateComponents(year: 2025, month: 4, day: 20))!
    NavigationStack {
        DetailView(date: exampleDate)
            .environmentObject(MistakeManager.exampleOnly())
    }
}
