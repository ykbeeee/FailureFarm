//
//  Untitled 2.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/16/25.
//
import SwiftUI

struct PeachToday: View {
    var mistake: Mistake
    @State private var navigateToCalView = false
    
    var body: some View {
        
        ZStack{ //상단 아이콘
            Image("bkgr")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Spacer()
                VStack {
                    ZStack {
                        Text("")
                            .frame(width: 390, height: 130)
                            .background(Color("리드핑크"))
                            .cornerRadius(15)
                            .padding(.top,20)
                        
                        HStack {
                            Text("Date")// is an example
                                .font(.custom("EF_jejudoldam", size: 30))
                                .frame(width:98, height: 98)
                                .background(Color("핑크"))
                                .cornerRadius(20)
                                .padding(.leading, 30)
                                .padding(.top,18)
                            Spacer()
                            if let weather = WeatherType(rawValue: mistake.result) {
                                Image(weather.afterSelect())
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120)
                                    .padding(.leading, 10)
                                    .padding(.top, 22)
                            }
                            
                            Spacer()
                            Image("풋복-핑")// is an example
                                .resizable()
                                .scaledToFit()
                                .frame(width: 110)
                                .padding(.trailing,30)
                                .padding(.top,20)
                            
                        }
                        Spacer()
                        
                    }
                    Text("운전과 관련된 실수를 하였다") //선택항목 텍스트
                        .font(.custom("EF_jejudoldam", size: 20))
                        .minimumScaleFactor(0.5)
                        .lineLimit(3)
                        .frame(width: 390, height: 100)
                        .background(Color("리드핑크"))
                        .cornerRadius(12)
                        .padding()
                    
                    Image("오늘의 복숭아")
                        .resizable()
                        .frame(width: 200, height: 60)

                    ZStack {
                        Text("") //그날의 복숭아 배경
                            .frame(width: 390, height: 400)
                            .background(Color("리드핑크"))
                            .cornerRadius(12)
                        
                        VStack {
                            Text("복숭아품종")
                                .font(.custom("EF_jejudoldam", size: 25))
                                .frame(width: 200, height: 60)
                                .background(Color("핑크"))
                                .cornerRadius(12)
                            Text("특징")
                                .font(.custom("EF_jejudoldam", size: 17))
                                .frame(width: 350, height: 50)
                                .background(Color("핑크"))
                                .cornerRadius(12)
                                .padding()
                            Image("서왕모")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                                .cornerRadius(12)
                            
                            
                        }
                    }
                    
                }
                NavigationLink(destination: CalView()) {
                    Image("확인")
                        .resizable()
                        .frame(width: 261, height: 50)
                        .padding()
                }
            }
        }
    }
    }



#Preview {
    NavigationStack {
        PeachToday(mistake: Mistake(
            date: Date(),
            text: "운전과 관련된 실수를 하였다",
            feeling: "smile",
            result: "비"
        ))
    }
}
