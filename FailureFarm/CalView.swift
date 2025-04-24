//
//  ContentView.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/14/25.
//

import SwiftUI


struct CalView: View {
    @EnvironmentObject var mistakeManager: MistakeManager  // 전체 실수 관리
    @State private var currentDate = Date()  // 보여주고 있는 달력의 기준 날짜
    @State private var selectedDate: Date? = nil  // 유저가 탭한 날짜
    
    private var calendar: Calendar {  // 그래고리안 달력
        Calendar(identifier: .gregorian)
    }

    private var daysInMonth: Int {  // 달이 며칠까지 있는지 계산
        guard let range = calendar.range(of: .day, in: .month, for: currentDate)
        else { return 0 }
        return range.count
    }

    private var firstWeekday: Int {  // 1일이 무슨 요일에 시작하는지 계산
        let components = calendar.dateComponents(
            [.year, .month],
            from: currentDate
        )
        guard let firstDayOfMonth = calendar.date(from: components) else {
            return 1
        }
        return calendar.component(.weekday, from: firstDayOfMonth)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Image("bkgr")
                    .resizable()
                    .ignoresSafeArea()
                // MARK: 저장 버튼
                VStack(spacing: 20) {
                    HStack {
                        Spacer()

                        NavigationLink(
                            destination: Setting()
                                .navigationBarBackButtonHidden(true)
                        ) {
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.trailing, 20)
                                .padding(.bottom, 20)
                        }
                    }

                    HStack {
                        Button(action: {  // 월 변경 기능 (좌우 화살표)
                            if let newDate = calendar.date(
                                byAdding: .month,
                                value: -1,
                                to: currentDate
                            ) {
                                currentDate = newDate
                            }
                        }) {
                            Image(systemName: "chevron.left")
                        }

                        Spacer()

                        Text(currentDate.formatted(.dateTime.year().month()))
                            .font(.custom("EF_jejudoldam", size: 20))

                        Spacer()

                        Button(action: {
                            if let newDate = calendar.date(
                                byAdding: .month,
                                value: 1,
                                to: currentDate
                            ) {
                                currentDate = newDate
                            }
                        }) {
                            Image(systemName: "chevron.right")
                        }
                        .padding(.trailing, 10)
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 5)

                    HStack {  // 요일표시
                        ForEach(
                            ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
                            id: \.self
                        ) { day in
                            Text(day)
                                .font(.custom("EF_jejudoldam", size: 12))
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 15)

                    let totalDays =
                        currentDate.daysInMonth(using: calendar)
                        + currentDate.firstWeekday(using: calendar) - 1 // 이번 달이 몇일까지 있는지 계산 + 현재 월의 1일이 무슨 요일에 시작하는 지 계산 .시작 요일 맞추기 위해 앞에 몇 칸 띄워야 하는 지
                    let columns = Array(
                        repeating: GridItem(.flexible()),
                        count: 7
                    )

                    ZStack {
                        LazyVGrid(columns: columns, spacing: 15) {
                            // MARK: 달력 표현
                            ForEach(0..<totalDays, id: \.self) { index in  // 한달의 모든 날짜를 화면 출력
                                if index < currentDate.firstWeekday(
                                    using: calendar
                                ) - 1 {
                                    Color.clear.frame(height: 60)
                                } else {
                                    let day = currentDate.dayNumber(for: index, using: calendar)  // 이번 달 달력에서 index 위치가 가리키는 날짜 숫자를 계산. 비워야 하는 요일 칸을 제외하고 day 1부터 시작되도록 맞춰준다.
                                    VStack(spacing: 5) {

                                        if let cellDate = currentDate.cellDate(forDay: day, using: calendar), // 실제 객체(cellDate) 만들어줌
                                           let mistake = mistakeManager.mistakes.first(where: { calendar.isDate($0.date, inSameDayAs: cellDate) }), // mistakeManager 안에 있는 실수 목록 중 해당 cellDate에 작성된 실수가 있는 지 확인
                                           let fruit = FruitType(rawValue: mistake.feeling) {
                                            // 복숭아 감정을 FruitType enum으로 변환
                                            NavigationLink(destination: DetailView(date: cellDate)) {
                                                Image(fruit.PeachTypes()) 
                                                    .resizable()
                                                    .frame(width: 40, height: 40)
                                                    .clipShape(.rect(cornerRadius: 12))
                                
                                            }
                                        } else {
                                            Color.clear.frame(width: 40, height: 40)
                                        }

                                        Text("\(day)")
                                            .font(.caption)
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 50, height: 60)
                                    .background(Color.white.opacity(0.1))
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 10)
                                    )
                                }
                            }
                        }
                        .padding(.bottom, 80)
                        .padding(.horizontal, 15)
                    }

                    //                    if let selectedDate {
                    //                        NavigationLink(value: selectedDate) {
                    //                            Text("") // 이거때문에 묘하게 늘어나는거임
                    //                        }
                    //                    }

                    // MARK: 작성 버튼
                    NavigationLink(destination: WritingView()) {
                        Image("작성하기")
                            .resizable()
                            .frame(width: 198, height: 53)
                            .padding()
                    }
                }
            }
            //            .navigationBarHidden(true)
            //            .navigationBarBackButtonHidden(false)

            //            .navigationDestination(for: Date.self) { date in
            //                DetailView(date: date)
            //                    .environmentObject(mistakeManager)
            //            }

        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(false)
    }
}

#Preview {
    NavigationStack {
        CalView()
            .environmentObject(MistakeManager())
    }
}

extension Date {
    func startOfMonth(using calendar: Calendar) -> Date? {
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)
    }

    func daysInMonth(using calendar: Calendar) -> Int {
        guard let range = calendar.range(of: .day, in: .month, for: self) else {
            return 0
        }
        return range.count
    }

    func firstWeekday(using calendar: Calendar) -> Int {
        guard let firstDay = self.startOfMonth(using: calendar) else {
            return 1
        }
        return calendar.component(.weekday, from: firstDay)
    }

    func cellDate(forDay day: Int, using calendar: Calendar) -> Date? {
        var components = calendar.dateComponents([.year, .month], from: self)
        components.day = day
        return calendar.date(from: components)
    }
    
    func dayNumber(for index: Int, using calendar: Calendar) -> Int {
        return index - self.firstWeekday(using: calendar) + 2
    }
}
