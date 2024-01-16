//
//  SplashScreen.swift
//  VITTY
//
//  Created by Ananya George on 12/22/21.
//

import SwiftUI

struct SplashScreen: View {
    @State private var showInstructions = false

    @State var selectedTab: Int = 0
    @State var onboardingComplete: Bool = false
    @EnvironmentObject var authState: AuthService
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selectedTab){
                    ForEach(0..<3) { _ in
                        SplashScreenIllustration(selectedTab: $selectedTab)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                SplashScreenTabIndicator(selectedTab: $selectedTab)
                Spacer(minLength: 50)
                if selectedTab < 2 {
                    CustomButton(buttonText:"Next") {
                        selectedTab += 1
                    }
                    .padding(.vertical)
                    
                } else {
                    CustomButton(buttonText:"Sign in with Apple",imageString: "logo_apple"){
                        print("跳转页面")
                        showInstructions = true
                    }
                 
                    SignupOR()
                    
                    CustomButton(buttonText: "Sign in with Google", imageString: "logo_google"){
                        showInstructions = true
                    }
              
                    NavigationLink(destination:
                                    InstructionsView(),
                                   isActive: $showInstructions
                    ) {
                        EmptyView()
                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    
                }
                Spacer(minLength: 50)
                
                if true {
                    NavigationLink(destination: InstructionsView()) {
                        EmptyView()
                    }
                }
                
            }
            .transition(.customTransition)
            .padding()
            .background(Image((selectedTab % 2 == 0) ? "SplashScreen13BG" : "SplashScreen2BG").resizable().scaledToFill().edgesIgnoringSafeArea(.all))
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

extension AnyTransition {
    static var customTransition: AnyTransition {
        let transition = AnyTransition.scale(scale: 0.3, anchor: .topTrailing)
            .combined(with: .opacity)
        return transition
    }
}
