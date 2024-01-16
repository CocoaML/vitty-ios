//
//  ContentView.swift
//  VITTY
//
//  Created by Ananya George on 11/7/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var authState: AuthService = AuthService()
    @StateObject var timeTableVM: TimetableViewModel = TimetableViewModel()
    // may not need this at all
    @StateObject var localNotificationsManager = NotificationsManager()
    @StateObject var notifVM = NotificationsViewModel()
    var body: some View {
        NavigationView {
            
            if isFirstLogin() {
                SplashScreen()
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    .onAppear {
                        UserDefaults.standard.setValue(true, forKey: "isfirst")
                    }
            } else {
                InstructionsView()
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    .animation(.default)
            }
        }
        .onAppear(perform: NotificationsManager.shared.getNotificationSettings)
        .onChange(of: NotificationsManager.shared.authStatus) { authorizationStat in
            
            switch authorizationStat {
            case .notDetermined:
                NotificationsManager.shared.requestPermission()
                break
            default:
                break
            }
            
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            NotificationsManager.shared.getNotificationSettings()
        }
        .environmentObject(authState)
        .environmentObject(timeTableVM)
        .environmentObject(notifVM)
    }
    
    func isFirstLogin() -> Bool {
//        if (UserDefaults.standard.value(forKey: "isfirst") ?? true) as! Bool {
//            return false
//        }
        return true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(authState: AuthService())
    }
}


