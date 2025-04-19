//
//  Untitled 2.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/16/25.
//
import SwiftUI
import SwiftData
// 실수 데이터를 나타내는 구조체
struct Mistake: Codable, Identifiable {
    var id = UUID()
    var date: Date
    var text: String
    var feeling: String // FruitType의 rawValue
    var result: String  // WeatherType의 rawValue
}

// 데이터 관리를 위한 클래스
class MistakeManager: ObservableObject {
    @Published var mistakes: [Mistake] = []
    private let userDefaultsKey = "savedMistakes"
    
    init() {
        loadMistakes()
    }
    
    func saveMistake(text: String, feeling: FruitType, result: WeatherType) {
        let newMistake = Mistake(
            date: Date(),
            text: text,
            feeling: feeling.rawValue,
            result: result.rawValue
        )
        
        mistakes.append(newMistake)
        saveMistakes()
    }
    
    private func saveMistakes() {
        if let encoded = try? JSONEncoder().encode(mistakes) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadMistakes() {
        if let savedMistakes = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedMistakes = try? JSONDecoder().decode([Mistake].self, from: savedMistakes) {
            mistakes = decodedMistakes
        }
    }
    
    func getMistakeForDate(_ date: Date) -> Mistake? {
        let calendar = Calendar.current
        return mistakes.first { mistake in
            calendar.isDate(mistake.date, inSameDayAs: date)
        }
    }
    
    func getAllMistakes() -> [Mistake] {
        return mistakes
    }
}

struct WritingView: View {
    
    @EnvironmentObject var mistakeManager: MistakeManager
    @State private var mistakeResult: String?
    @State private var selectedFruit: FruitType = .smile
    @State private var selectedWeather: WeatherType? = nil
    @State private var mistakeText: String = "여기에 입력해주세요."
    @State private var navigateToPeachToday = false
    @State private var isEditing: Bool = false
    @State private var showAlert = false
 
    
    // 나머지 코드는 그대로 유지...
    
    var body: some View {
        // 기존 UI 코드...
        
        // 저장 버튼 부분만 수정
        HStack {
            Button(action: {
                if let weather = selectedWeather, !mistakeText.isEmpty && mistakeText != "여기에 입력해주세요." {
                    mistakeManager.saveMistake(
                        text: mistakeText,
                        feeling: selectedFruit,
                        result: weather
                    )
                    navigateToPeachToday = true
                } else {
                    showAlert = true
                }
            }) {
                Image("저장")
                    .resizable()
                    .frame(width: 261, height:44)
                    .padding()
            }
            .alert("입력 필요", isPresented: $showAlert) {
                Button("확인", role: .cancel) {}
            } message: {
                Text("모든 항목을 입력해주세요.")
            }
            .background(
                NavigationLink(destination: PeachToday().navigationBarBackButtonHidden(true), isActive: $navigateToPeachToday) {
                    EmptyView()
                }
            )
        }
    }
}

enum FruitType: String, CaseIterable, Identifiable {
    case smile = "smile"
    case surprised = "surprised"
    case sweating = "sweating"
    case dead = "dead"
    
    var id: String { self.rawValue }
    
    func beforeSelect() -> String {
        switch self {
        case .smile:
            return "풋복-50"
        case .surprised:
            return "핑복-50"
        case .sweating:
            return "황도-50"
        case .dead:
            return "갈복-50"
        }
    }
    
    func afterSelect() -> String {
        switch self {
        case .smile:
            return "풋복-핑"
        case .surprised:
            return "핑복-핑"
        case .sweating:
            return "황도-핑"
        case .dead:
            return "갈복-핑"
        }
    }
}

enum WeatherType: String, CaseIterable, Identifiable {
    case sunny = "해"
    case rainy = "비"
    case thunder = "천둥"
    case snow = "눈"
    
    var id: String { self.rawValue } // 복숭아에서도 나오는데 반복이 가능한가?
    
    // 이미지 이름 연결
    func beforeSelect() -> String { // 날씨와 복숭아 동일하게 적용
        switch self {
        case .sunny:
            return "해-선택전"
        case .rainy:
            return "비-선택전"
        case .thunder:
            return "천둥-선택전"
        case .snow:
            return "눈-선택전"
        }
    }
    
    func afterSelect() -> String {
        switch self {
        case .sunny:
            return "해-선택후"
        case .rainy:
            return "비-선택후"
        case .thunder:
            return "천둥-선택후"
        case .snow:
            return "눈-선택후"
        }
    }
}
    
  
#Preview {
    NavigationView {
        WritingView()
            .environmentObject(MistakeManager())
    }
}
