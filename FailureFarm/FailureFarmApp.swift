//
//  FailureFarmApp.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/14/25.
//

import SwiftUI

@main
struct FailureFarmApp: App {
    @StateObject private var mistakeManager = MistakeManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WritingView().navigationBarBackButtonHidden(true)
            }
            .environmentObject(mistakeManager)
        }
    }
}
