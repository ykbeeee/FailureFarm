//
//  ContentView.swift
//  FailureFarm
//
//  Created by Libby Bae on 4/14/25.
//

import SwiftUI

struct SplashImage: View {
    @State private var isActive = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("bkgr")
                    .resizable()
                    .ignoresSafeArea()

                
                VStack {
                    Text("과실수목원")
                        .padding(.top, 300)
                        .font(.custom("EF_jejudoldam", size: 60))
                    Image("Peaches")
                        .resizable()
                        .frame(width: 700, height: 500)
                        .padding(.top, 50)
                        .padding(.leading, 100)
                        .padding(.trailing, 100)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isActive = true
                }
            }
            .navigationDestination(isPresented: $isActive) {
                CalView()
            }
        }
        }
    }
#Preview {
    SplashImage()
}
