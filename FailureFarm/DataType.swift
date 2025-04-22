//
//  DataType.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/21/25.
//

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
