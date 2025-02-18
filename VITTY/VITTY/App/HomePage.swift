//
//  HomePage.swift
//  VITTY
//
//  Created by Ananya George on 12/23/21.
//

import SwiftUI


struct HomePage: View {
    //    @State var tabSelected: Int = (Calendar.current.dateComponents([.weekday], from: Date()).weekday ?? 1) - 1
    @State var tabSelected: Int = Date.convertToMondayWeek()
    @State var goToSettings: Bool = false
    @State var showLogout: Bool = false
    @EnvironmentObject var timetableViewModel: TimetableViewModel
    @EnvironmentObject var authVM: AuthService
    @EnvironmentObject var notifVM: NotificationsViewModel
    @StateObject var RemoteConf = RemoteConfigManager.sharedInstance
    @AppStorage("examMode") var examModeOn: Bool = false
    @AppStorage(AuthService.notifsSetupKey) var notifsSetup = false
    var body: some View {
        ZStack {
            VStack {
                // MARK: force crash button
                //                Button {
                //                    assert(1 == 2, "Maths failure!")
                //                } label: {
                //                    Text("forcing a crash")
                //                }
                
                VStack(alignment:.leading) {
                    HomePageHeader(goToSettings: $goToSettings, showLogout: $showLogout)
                        .padding()
                    HomeTabBarView(tabSelected: $tabSelected)
                }
                // TODO: change timetable scroll view to implement all of this
                TabView(selection: $tabSelected) {
                    
                    ForEach(0..<7) { tabSel in
                        //                        if let selectedTT = timetableViewModel.timetable[TimetableViewModel.daysOfTheWeek[tabSel]] {
                        //                            TimeTableScrollView(selectedTT: selectedTT, tabSelected: $tabSelected).environmentObject(timetableViewModel)
                        //                        }
                        if tabSel == 0 {
                            TimeTableScrollView(selectedTT: [],
                                                tabSelected: $tabSelected).environmentObject(timetableViewModel)
                        } else {
                            TimeTableScrollView(selectedTT:
                                                    [Classes(), Classes(), Classes(), Classes(), Classes(),
                                                     Classes(), Classes(), Classes(), Classes(),Classes()],
                                                tabSelected: $tabSelected).environmentObject(timetableViewModel)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                NavigationLink(destination: SettingsView().environmentObject(timetableViewModel).environmentObject(authVM).environmentObject(notifVM), isActive: $goToSettings) {
                    EmptyView()
                }
                if examModeOn {
                    ExamHolidayMode()
                }
            }
            .blur(radius: showLogout ? 10 : 0)
            .onAppear {
                tabSelected = Date.convertToMondayWeek()
            }
            if showLogout {
                LogoutPopup(showLogout: $showLogout).environmentObject(authVM)
            }
        }
        .padding(.top)
        .background(Image(timetableViewModel.timetable[TimetableViewModel.daysOfTheWeek[tabSelected]]?.isEmpty ?? false ? "HomeNoClassesBG" : "HomeBG").resizable().scaledToFill().edgesIgnoringSafeArea(.all))
        .onAppear {
            timetableViewModel.getData {
                if !notifsSetup {
                    notifVM.setupNotificationPreferences(timetable: timetableViewModel.timetable)
                    print("Notifications set up")
                }
                
            }
            print("tabSelected: \(tabSelected)")
            //            LocalNotificationsManager.shared.getAllNotificationRequests()
            print("calling update notifs from homepage")
            notifVM.updateNotifs(timetable: timetableViewModel.timetable)
            timetableViewModel.updateClassCompleted()
            notifVM.getNotifPrefs()
            
            print(goToSettings)
            print("remote config settings \(RemoteConf.onlineMode)")
        }
        .animation(.default)
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage().environmentObject(TimetableViewModel()).environmentObject(AuthService()).environmentObject(NotificationsViewModel())
    }
}
