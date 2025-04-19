import SwiftUI

struct Setting: View {
    @State private var selectedDates: Set<DateComponents> = []
    @State private var isPushEnabled: Bool = true
    @State private var navigateToCalView = false

    var body: some View {
        ZStack {
            Image("bkgr")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Image("환경설정")
                        .resizable()
                        .frame(width: 120, height: 40)
                        .padding(.leading, 25)
                        .padding(.top, 80)
                    Spacer()
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.9))
                        .frame(width: 360, height: 150)
                        .shadow(radius: 4)
                    
                    VStack(spacing: 15) {
                        HStack {
                            Toggle(isOn: $isPushEnabled) {
                                Image("푸쉬 알림")
                                    .resizable()
                                    .frame(width: 140, height: 35)
                                
                            }
                            Spacer()
                            
                        }
                        .padding(.horizontal, 30)
                        
                        HStack {
                            DatePicker(selection: .constant(Date()), displayedComponents: .hourAndMinute) {
                                Image("시간")
                                    .resizable()
                                    .frame(width: 140, height: 35)
                            }
                            Spacer()
                            
                        }
                        .padding(.horizontal, 30)
                    }
                }
                Spacer()
            }
            .padding(.bottom, 50)
            
            NavigationLink(destination: CalView().navigationBarBackButtonHidden(true)) {
                Image("확인")
                    .resizable()
                    .frame(width: 200, height: 40)
                    .padding()
            }
        }
    }
}

#Preview {
    NavigationView {
        Setting()
    }
}
