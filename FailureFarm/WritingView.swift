//
//  Untitled 2.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/16/25.
//
import SwiftUI
import SwiftData


struct WritingView: View {
    
    @EnvironmentObject var mistakeManager: MistakeManager
    @State private var mistakeResult: String?
    @State private var selectedFruit: FruitType = .smile
    @State private var selectedWeather: WeatherType? = nil
    @State private var mistakeText: String = "여기에 입력해주세요."
    @State private var navigateToPeachToday = false
    @State private var isEditing: Bool = false
    @State private var showAlert = false
    @State private var todayString: String = ""
 
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bkgr")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    ZStack {
                        Text("")
                            .frame(width: 360, height: 100)
                            .background(Color("리드핑크"))
                            .cornerRadius(15)
                        HStack {
                            Text(todayString)
                                .frame(width: 75, height: 75)
                                .font(.custom("EF_jejudoldam", size: 16))
                                .background(Color("핑크"))
                                .cornerRadius(15)
                                .padding(.leading,40)

                            
                            Spacer()

                            Text("오늘 어떤 실수를 했나요?")
                                .font(.custom("EF_jejudoldam", size: 18))
                                .padding(.trailing, 70)

                            
                                .onAppear {
                                    let date = Date()
                                    let calendar = Calendar.current
                                    let day = calendar.component(.day, from: date)

                                    let formatter = DateFormatter()
                                    formatter.locale = Locale(identifier: "en_US")
                                    formatter.dateFormat = "MMM "
                                    let month = formatter.string(from: date)

                                    let suffix: String
                                    switch day {
                                    case 11, 12, 13:
                                        suffix = "th"
                                    default:
                                        switch day % 10 {
                                        case 1: suffix = "st"
                                        case 2: suffix = "nd"
                                        case 3: suffix = "rd"
                                        default: suffix = "th"
                                        }
                                    }

                                    todayString = "\(month) \(day)\(suffix)"
                                }
                        }
                    }
                    TextEditor(text: $mistakeText)
                        .frame(width: 360, height: 150)
                        .font(.custom("EF_jejudoldam", size: 15))
                        .cornerRadius(15)
            

                    HStack {
                        Image("실수 후 기분")
                            .resizable()
                            .frame(width: 160, height: 47)
                            .padding(.top, 10)
                            .padding(.leading, 30)
                        
                        Spacer()
                    }
                   
                    
                    HStack(spacing: 20) {
                        ForEach(WeatherType.allCases) { weather in
                            Image(weather == selectedWeather ? weather.afterSelect() : weather.beforeSelect())
                                .resizable()
                                .scaledToFill() //짜그러짐 이슈
                                .frame(width: 70, height: 70)
                                .onTapGesture {
                                    selectedWeather = weather
                                }
                        }
                    }
                    .padding(.top, 5)
                        
                    HStack {
                    Image("실수의 결과")
                        .resizable()
                        .frame(width: 160, height: 47)
                        .padding(.top, 10)
                        .padding(.leading, 30)
                    
                    Spacer()
                }
                    
                    HStack(spacing: 20) {
                        ForEach(FruitType.allCases) { fruit in
                            Image(fruit == selectedFruit ? fruit.afterSelect() : fruit.beforeSelect())
                                .resizable()
                                .frame(width: 70, height: 70)
                                .onTapGesture {
                                    selectedFruit = fruit
                                }
                        }
                    }
                    .padding(.top, 5)

                    
                    NavigationLink(destination: { // 실수 데이터를 넘겨줌
                        let mistake = Mistake(
                            date: Date(),
                            text: mistakeText,
                            feeling: selectedFruit.rawValue,
                            result: selectedWeather?.rawValue ?? ""
                        )
                        return PeachToday(mistake: mistake)
                            .onAppear {
                                mistakeManager.saveMistake(text: mistake.text, feeling: selectedFruit, result: selectedWeather ?? .sunny)
                            }
                            .navigationBarBackButtonHidden(true)
                    }) {
                        Image("저장")
                            .resizable()
                            .frame(width: 261, height: 44)
                    }
                }
            }
        }
    }
    }



    
  
#Preview {
    NavigationStack {
        WritingView()
            .environmentObject(MistakeManager.exampleOnly())
    }
}
