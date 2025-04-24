//
//  DataType.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/21/25.
//

import Foundation // JSON 처리를 위함

enum FruitType: String, CaseIterable, Identifiable { // 실수의 결과를 표현하는 enum
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
    
    func saveMistake(text: String, feeling: FruitType, result: WeatherType) { // 새로운 실수가 만들어지면 mistake 배열에 추가 후 저장
        let newMistake = Mistake(
            date: Date(),
            text: text,
            feeling: feeling.rawValue,
            result: result.rawValue
        )
        mistakes.append(newMistake)
        saveMistakes()
    }
    
    private func saveMistakes() { //MARK: [Mistake] 타입, Mistake 객체들의 배열 저장(encode)
        if let encoded = try? JSONEncoder().encode(mistakes) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)  //UserDefault에 저장
        }
    }
    
    private func loadMistakes() { // 앱 실행시 UserDefaults에 저장된 데이터를 불러옴
        if let savedMistakes = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedMistakes = try? JSONDecoder().decode([Mistake].self, from: savedMistakes) {
            mistakes = decodedMistakes
        } // UserDefaults 에서 저장된 Data를 꺼내서 다시 [Mistake] 구조체 배열로 복원(decode)
    }
    
    func getMistakeForDate(_ date: Date) -> Mistake? { // 특정 날짜에 대한 실수 찾기
        let calendar = Calendar.current
        return mistakes.first { mistake in
            calendar.isDate(mistake.date, inSameDayAs: date)
        }
    }
    
    func getAllMistakes() -> [Mistake] { // 전체 실수 반환
        return mistakes
    }
    
}

extension MistakeManager { //뷰에서 사용할 수 있도록 기능 확장
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
        case .surprised: return "신비"
        case .sweating: return "마도카"
        case .dead: return "개복숭아"
        }
    }

    var peachDescription: String {
        guard let fruit = FruitType(rawValue: feeling) else { return "특징" }
        switch fruit {
        case .smile:
            return "원반 모양의 납작한 형태를 지닌 독특한 형태의 복숭아 품종으로서 당도와 맛이 매우 좋다. 과즙이 많고 무른편이다."
        case .surprised:
            return "당도가 높고 신맛이 적으며 복숭아 고유의 풍미가 매우 진한 최우수 복숭아 품종이다. 재배 시 낙과가 거의 없어 인기가 많다."
        case .sweating:
            return "과육은 단단하며 사각거리는 식감을 준다. 하지만, 비료를 일정하게 주지 않으면 당도가 한쪽으로 편중되는 과육의 갈변현상이 발생한다."
        case .dead:
            return "친식, 기침, 기관지염 등에 효과가 있다. 병충해에 강하고 재배가 쉬운 야생성 복숭아다."
        }
    }

    var peachImage: Image {
        guard let fruit = FruitType(rawValue: feeling) else { return Image("오늘의 복숭아") }
        switch fruit {
        case .smile: return Image("거반도")
        case .surprised: return Image("신비")
        case .sweating: return Image("마도카")
        case .dead: return Image("개복숭아")
        }
    }
}

extension FruitType {
    /// 복숭아 품종 (달력용)
    func PeachTypes() -> String { //FruitType 감정 값에 따라 연결된 복숭아 품종 이름 반환
        switch self {
        case .smile: return "거반도"
        case .surprised: return "신비"
        case .sweating: return "마도카"
        case .dead: return "개복숭아"
        }
    }
}
