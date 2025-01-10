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
            
            Button {
                isOnboardCompleted = true
            } label: {
                Text("Explore Now")
                    .padding()
                    .foregroundStyle(Color(.appWhiteText))
                    .font(.poppins(.semibold, size: 17))
            }
            .background(Color(.appTheme))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(maxHeight: .infinity,alignment: .bottom)
            .safeAreaPadding(.bottom)
        }
    }
}
