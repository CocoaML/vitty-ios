//
//  NotificationsViewHeader.swift
//  VITTY
//
//  Created by Ananya George on 1/21/22.
//

import SwiftUI

struct NotificationsViewHeader: View {
    @EnvironmentObject var ttVM: TimetableViewModel
    @EnvironmentObject var authVM: AuthService
    var buttonAction: ()->Void
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .onTapGesture {
                    buttonAction()
                }
            Spacer()
            Text("Notification Settings")
                .font(.custom("Poppins-Bold", size: 20))
            Spacer()
        }
        .foregroundColor(.white)
        .font(.custom("Poppins-Regular",size: 18))
    }
}

struct NotificationsViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsViewHeader(buttonAction: {})
            .background(Color.black)
    }
}
