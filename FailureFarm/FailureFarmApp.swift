//
//  FailureFarmApp.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/14/25.
//

import SwiftUI

@main // 앱의 시작을 정의
struct FailureFarmApp: App { // 앱 전체를 정의, 내부 scene을 구성하고 앱의 첫 화면을 결정
    @StateObject private var mistakeManager = MistakeManager() // 앱 전체에서 공유할 데이터 모델(MistakeManager) 생성
    
    var body: some Scene {
        WindowGroup {
            SplashImage()
                .environmentObject(mistakeManager)
        }
    }
}
