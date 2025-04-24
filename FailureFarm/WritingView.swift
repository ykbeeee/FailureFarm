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
    @State private var mistakeText: String = ""
    @State private var navigateToPeachToday = false
    @State private var isEditing: Bool = false
    @State private var showAlert = false
    @State private var todayString: String = "" // 오늘 날짜를 불러옴
    @FocusState private var isTextEditorFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bkgr")
                    .resizable()
                    .ignoresSafeArea()

                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isTextEditorFocused = false
                    }

                VStack {
                    ZStack {
                        Text("")
                            .frame(width: 360, height: 100)
                            .background(Color("리드핑크"))
                            .clipShape(.rect(cornerRadius: 15))

                        HStack {
                            Text(todayString) // MARK: 오늘 날짜 보여줌
                                .frame(width: 75, height: 75)
                                .font(.custom("EF_jejudoldam", size: 16))
                                .background(Color("핑크"))
                                .padding(.leading,40)
                                .clipShape(.rect(cornerRadius: 15))

                            
                            Spacer()

                            Text("오늘 어떤 실수를 했나요?")
                                .font(.custom("EF_jejudoldam", size: 21))
                                .padding(.trailing, 37)

                            
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
                    TextEditor(text: $mistakeText) // MARK: 유저가 실수 작성
                        .padding()
                        .focused($isTextEditorFocused)
                        .frame(width: 360, height: 150)
                        .background(.white)
                        .font(.custom("EF_jejudoldam", size: 15))
                        .clipShape(.rect(cornerRadius: 15))
                        .padding(.horizontal, 16)
                        .scrollContentBackground(.hidden)
                        .overlay(alignment: .topLeading) { // placeholder 구현
                            if mistakeText.isEmpty {
                                Text("오늘의 실수를 입력해주세요.")
                                    .font(.custom("EF_jejudoldam", size: 15))
                                    .foregroundColor(.gray)
                                    .padding(.top, 22) // 내부 위치 조정
                                    .padding(.leading, 35)
                                    .focused($isTextEditorFocused)
                            }
                        }
            

                    HStack {
                        Image("실수 후 기분")
                            .resizable()
                            .frame(width: 160, height: 47)
                            .padding(.top, 10)
                            .padding(.leading, 30)
                        
                        Spacer()
                    }
                   
                    
                    HStack(spacing: 20) {
                        ForEach(WeatherType.allCases) { weather in // MARK: 날씨들을 버튼처럼 보여줌. 선택하면 연핑크에서 핑크로 변함
                            Image(weather == selectedWeather ? weather.afterSelect() : weather.beforeSelect())
                                .resizable()
                                .scaledToFill()
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
                        ForEach(FruitType.allCases) { fruit in // MARK: 복숭아들을 버튼처럼 보여줌. 선택하면 연핑크에서 핑크로 변함
                            Image(fruit == selectedFruit ? fruit.afterSelect() : fruit.beforeSelect())
                                .resizable()
                                .frame(width: 70, height: 70)
                                .onTapGesture {
                                    selectedFruit = fruit
                                }
                        }
                    }
                    .padding(.top, 5)

                    
                    NavigationLink(destination: { // MARK: 저장버튼을 누르면 입력 내용을 Mistake 인스턴스 생성. 앱 데이터에 추가됨. PeachToday 뷰로 이동하여 유저가 작성한 데이터를 넘겨줌
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
                            .padding(.top, 10)
                    }
                }
            }
        }
    }
    }

    
  
#Preview {
    NavigationStack {
        WritingView()
            .environmentObject(MistakeManager.exampleOnly()) // MARK: 예시데이터를 보여줌
    }
}
