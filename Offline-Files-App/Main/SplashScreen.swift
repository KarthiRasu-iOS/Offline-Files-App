//
//  SplashScreen.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 10/01/25.
//


import SwiftUI

struct SplashScreen: View {
    @State private var scale = 0.5
    @Binding var isActive : Bool
    
    var body: some View {
        ZStack {
            VStack(spacing:0) {
                Image(.splashIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200,height: 200)
                
                Text(AppStrings.appName)
                    .font(.poppins(.bold, size: 30))
                    .foregroundStyle(Color.appTextPrimary)
                    .kerning(5)
            }
            .scaleEffect(scale)
            .onAppear(perform: {
                withAnimation(.easeInOut(duration: 0.7)) {
                    self.scale = 1
                }
            })
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    isActive = true
                }
            }
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color(.appBgPrimary))

    }
}
