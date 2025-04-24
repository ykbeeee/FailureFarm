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
                            .frame(width: 360, height: 100)
                            .background(Color("리드핑크"))
                            .clipShape(.rect(cornerRadius: 15))
                            .padding(.top,40)
                        
                        HStack {
                            Text(mistake.date.formatted(.dateTime.month().day()))
                                .font(.custom("EF_jejudoldam", size: 16)) // 날짜를 가져옴
                                .frame(width:70, height: 70)
                                .background(Color("핑크"))
                                .clipShape(.rect(cornerRadius: 15))
                                .padding(.leading, 50)
                                .padding(.top,40)
                            Spacer()
                            if let weather = WeatherType(rawValue: mistake.result) {
                                Image(weather.afterSelect()) // writing view에서 선택한 날씨 중 하나
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70)
                                    .padding(.leading, 10)
                                    .padding(.top, 35)
                            }
                            
                            Spacer()
                            if let fruit = FruitType(rawValue: mistake.feeling) {
                                Image(fruit.afterSelect()) // writing view에서 선택한 복숭아 중 하나
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70)
                                    .padding(.trailing,50)
                                    .padding(.top,40)
                            }
                        }
                        Spacer()
                        
                    }
                    Text(mistake.text) //선택항목 텍스트
                        .font(.custom("EF_jejudoldam", size: 20))
                        .minimumScaleFactor(0.5)
                        .lineLimit(3)
                        .frame(width: 360, height: 100)
                        .background(Color("리드핑크"))
                        .clipShape(.rect(cornerRadius: 15))
                        .padding()
                    
                    Image("오늘의 복숭아")
                        .resizable()
                        .frame(width: 200, height: 60)

                    ZStack {
                        Text("") //그날의 복숭아 배경
                            .frame(width: 360, height: 400)
                            .background(Color("리드핑크"))
                            .clipShape(.rect(cornerRadius: 15))
                        VStack {
                            Text(mistake.peachName)
                                .font(.custom("EF_jejudoldam", size: 25))
                                .frame(width: 200, height: 60)
                                .background(Color("핑크"))
                                .clipShape(.rect(cornerRadius: 15))
                            Text(mistake.peachDescription)
                                .font(.custom("EF_jejudoldam", size: 17))
                                .frame(width: 350, height: 80)
                                .background(Color("핑크"))
                                .clipShape(.rect(cornerRadius: 15))
                                .padding()
                            mistake.peachImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                                .clipShape(.rect(cornerRadius: 15))
                            
                        }
                    }
                    
                }
                NavigationLink(destination: CalView()) {
                    Image("확인")
                        .resizable()
                        .frame(width: 261, height: 50)
                        .padding(.bottom, 30)
                }
            }
        }
    }
    }
