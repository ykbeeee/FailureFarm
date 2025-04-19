//
//  ContentView.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/14/25.
//

import SwiftUI

struct CalView2: View {
    @State private var selectedDate: Date? = nil
    @State private var showDetail = false
    @State private var navigateToWritingView = false
    @State private var selectedMonth: Date = Date()
    @State private var showMonthPicker = false
    @State private var navigateToSetting = false

    func formattedToday() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "date")
        formatter.dateFormat = "yyyy\nMMMdd\n(E)"
        return formatter.string(from: Date())
    }
  
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bkgr")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: Setting().navigationBarBackButtonHidden(true)) {
                            Image(systemName: "gearshape")
                                .font(.title2)
                                .padding(.trailing, 20)
                        }
                    }
                    
                    List {
                        HStack{
                            Text(formattedToday())
                                .font(.custom("EF_jejudoldam", size:20))
                                .frame(width:75,height:75)
                                .background(Color("핑크"))
                                .cornerRadius(12)
                            Spacer()
                            Image("핑복-핑")
                                .resizable()
                                .frame(width:75,height:75)
                            Spacer()
                            Image("천둥-선택후")
                                .resizable()
                                .frame(width:75,height:75)
                            Image("")
                            
                            
                        }
                        
                    }
                    
                    
                    Spacer()
                    NavigationLink(destination: WritingView().navigationBarBackButtonHidden(true)) {
                        Image("작성하기")
                            .resizable()
                            .frame(width: 198, height: 53)
                            .padding()
                    }
                    
                }
            }
        }
        }
    }
    
       #Preview {
        CalView2()
    }

