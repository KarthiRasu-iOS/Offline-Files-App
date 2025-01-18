//
//  ContentView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 09/01/25.
//

import SwiftUI
import CoreData

struct OnboardView: View {

    @AppStorage(AppStorageKeys.isOnboardCompleted.rawValue) var isOnboardCompleted = false
    @AppStorage(AppStorageKeys.userName.rawValue) var userName = ""
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color(.appBgPrimary)
                .ignoresSafeArea()
            
            VStack {
                Image(.filesWalkthrough)
                    .resizable()
                    .scaledToFit()
                Text(AppStrings.walkthrough)
                    .multilineTextAlignment(.center)
                    .font(.poppins(.medium, size: 17))
            }
            .padding()
            
            VStack(spacing:15) {
                TextField("Enter name", text: $userName)
                    .multilineTextAlignment(.center)
                    .font(.poppins(.medium, size: 15))
                    .frame(width: .width*0.8,height: 45)
                    .background(Color.appBgSecondary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .autocorrectionDisabled()
                
                Button {
                    isOnboardCompleted = true
                } label: {
                    Text("Explore Now")
                        .padding()
                        .foregroundStyle(Color(userName.isEmpty ? .appTextSecondary : .appWhiteText))
                        .font(.poppins(.semibold, size: 17))
                }
                .disabled(userName.isEmpty)
                .background(Color(userName.isEmpty ? .appBgSecondary : .appTheme))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .frame(maxHeight: .infinity,alignment: .bottom)
            .safeAreaPadding(.bottom)
        }
        .keyboardHeight($keyboardHeight)
        .offset(y: -keyboardHeight / 2)
        .ignoresSafeArea(.keyboard)
    }
}
