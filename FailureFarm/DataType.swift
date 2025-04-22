//
//  DataType.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/21/25.
//

import Foundation

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

extension MistakeManager {
    static func exampleOnly() -> MistakeManager {
        let manager = MistakeManager()
        let calendar = Calendar.current
        let exampleDate = calendar.date(from: DateComponents(year: 2025, month: 4, day: 20))!
        manager.mistakes = [
            Mistake(
                date: exampleDate,
                text: "분리수거 내놓는 것을 잊었다!",
                feeling: FruitType.surprised.rawValue,
                result: WeatherType.rainy.rawValue
            )
        ]
        return manager
    }
}

import SwiftUI

extension Mistake {
    var peachName: String {
        guard let fruit = FruitType(rawValue: feeling) else { return "오늘의 복숭아" }
        switch fruit {
        case .smile: return "거반도"
        case .surprised: return "마도카"
        case .sweating: return "신비"
        case .dead: return "개복숭아"
        }
    }

    var peachDescription: String {
        guard let fruit = FruitType(rawValue: feeling) else { return "특징" }
        switch fruit {
        case .smile:
            return "단단한 열매는 당도가 높고, 신맛이 적으며, 복숭아 고유의 풍미가 매우 진한 최우수 복숭아 품종이다. 재배 시 낙과가 거의 없어 인기가 많다."
        case .surprised:
            return "원반 모양의 납작한 형태를 지닌 기이한 복숭아로, 당도와 맛이 좋다. 과즙이 많고 무른 편이다."
        case .sweating:
            return "과육은 단단하며 사각거리는 식감을 준다. 해를 받는 쪽에 착색되며, 비료가 고르지 않으면 당도 편차가 생긴다."
        case .dead:
            return "친식, 기침, 기관지염 등에 효과가 있다. 병충해에 강하고 재배가 쉬운 야생성 복숭아다."
        }
    }

    var peachImage: Image {
        guard let fruit = FruitType(rawValue: feeling) else { return Image("오늘의 복숭아") }
        switch fruit {
        case .smile: return Image("거반도")
        case .surprised: return Image("마도카")
        case .sweating: return Image("신비")
        case .dead: return Image("개복숭아")
        }
    }
}

extension FruitType {
    /// 복숭아 품종 (달력용)
    func PeachTypes() -> String {
        switch self {
        case .smile: return "거반도"
        case .surprised: return "마도카"
        case .sweating: return "신비"
        case .dead: return "개복숭아"
        }
    }
}
