//
//  PeachToday.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/17/25.
//


//오늘날짜
import SwiftUI

struct PeachToday: View {
    @EnvironmentObject var mistakeManager: MistakeManager
    @State private var todayMistake: Mistake?
    
    var body: some View {
        
        ZStack{ //상단 아이콘
            Image("bkgr")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Spacer()
                ZStack {
                    Text("")
                        .frame(width: 380, height: 130)
                        .background(Color("리드핑크"))
                        .cornerRadius(15)
                    
                    HStack {
                        Text("Date")// is an example
                            .font(.custom("EF_jejudoldam", size: 30))
                            .frame(width:100, height: 100)
                            .background(Color("핑크"))
                            .cornerRadius(15)
                            .padding(.leading, 30)
                        Spacer()
                        Image("비-선택후")// is an example
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .padding(.leading, 10)
                        Spacer()
                        Image("풋복-핑")// is an example
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110)
                    }
                    
                    Spacer()
                    
                }
                VStack {
                    if let mistake = todayMistake {
                        Text("오늘의 실수")
                            .font(.custom("EF_jejudoldam", size: 20))
                        
                        Text(mistake.text)
                            .font(.custom("EF_jejudoldam", size: 15))
                            .padding()
                        
                        HStack {
                            Text("감정:")
                            Image(getFeelingImageName(mistake.feeling))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                            
                            Text("결과:")
                            Image(getResultImageName(mistake.result))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                        }
                    } else {
                        Text("오늘 저장된 실수가 없습니다.")
                            .font(.custom("EF_jejudoldam", size: 15))
                    }
                    
                    // 뒤로가기 버튼 등 추가 UI 요소...
                    
                    NavigationLink(destination: CalView().navigationBarBackButtonHidden(true)) {
                        Image("확인")
                            .resizable()
                            .frame(width: 261, height: 50)
                            .padding()
                    }
                }
            }
            .onAppear {
                todayMistake = mistakeManager.getMistakeForDate(Date())
            }
        }
    }
    
    // FruitType 이미지 이름 가져오기
    func getFeelingImageName(_ feeling: String) -> String {
        if let fruitType = FruitType(rawValue: feeling) {
            return fruitType.afterSelect()
        }
        return "풋복-핑" // 기본값
    }
    
    // WeatherType 이미지 이름 가져오기
    func getResultImageName(_ result: String) -> String {
        if let weatherType = WeatherType(rawValue: result) {
            return weatherType.afterSelect()
        }
        return "해-선택후" // 기본값
    }
}

#Preview {
    NavigationView {
        PeachToday()
    }
}
