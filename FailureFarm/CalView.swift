//
//  ContentView.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/14/25.
//

import SwiftUI

struct CalView: View {
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
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(false)
        }
    }
    
    struct CustomCalendarView: View {
        @Binding var selectedDate: Date?
        @Binding var showDetail: Bool
        var selectedMonth: Date
        
        let daysInMonth = 30
        let calendar = Calendar.current
        
        // 예시 저장된 스티커 데이터
        let entries: [CalEntry] = [
            CalEntry(date: Date(), sticker1: "풋복-핑", sticker2: "천둥-선택후"),
            CalEntry(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, sticker1: "핑복-핑", sticker2: "sticker4ImageName")
        ]
        var body: some View {
            
        }
        
        func sticker(for date: Date) -> (String?, String?) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let target = formatter.string(from: date)
        
            if let entry = entries.first(where: { formatter.string(from: $0.date) == target }) {
                return (entry.sticker1, entry.sticker2)
            }
            return (nil, nil)
        }
        
    }
    
    struct CalEntry {
        let date: Date
        let sticker1: String // image name
        let sticker2: String // image name
        
       
        }
    

    #Preview {
        CalView()
    }

