//
//  ClassCards.swift
//  VITTY
//
//  Created by Ananya George on 12/24/21.
//

import SwiftUI

struct ClassCards: View {
    var classInfo: Classes
    
    private var localStart: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: classInfo.startTime ?? Date())
    }
    @State var currentClass: Bool =  false
    @State var hideDescription: Bool = true
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack(alignment:.leading) {
                        Text(classInfo.courseName ?? "Course Name")
                            .font(Font.custom("Poppins-SemiBold",size:15))
                            .foregroundColor(Color.white)
                        HStack(spacing: 0) {
                            Text(classInfo.startTime ?? Date(), style: .time)
                            Text(" - ")
                            Text(classInfo.endTime ?? Date(), style: .time)
                        }
                            .font(Font.custom("Poppins-Regular",size:14))
                    }
                    .padding()
                    Spacer()
                    Image(systemName: hideDescription ? "chevron.down" : "chevron.up")
                        .font(Font.system(size: 18))
                        .padding()
                        .onTapGesture {
                            hideDescription.toggle()
                        }
                }
                if !hideDescription {
                    HStack {
                        Text("\(classInfo.slot ?? "Slot")")
                            .font(Font.custom("Poppins-Regular",size:14))
                        Spacer()
                        Text("\(classInfo.location ?? "Location")")
                            .font(Font.custom("Poppins-Regular",size:14))
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .foregroundColor(Color.vprimary)
            .padding()
        }
        .padding()
        .frame(height: hideDescription ? 100 : 155)
    }
}

struct ClassCards_Previews: PreviewProvider {
    static var previews: some View {
        ClassCards(classInfo: StringConstants.sampleClassDate)
    }
}
