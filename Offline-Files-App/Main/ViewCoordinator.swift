//
//  ViewCoordinator.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 10/01/25.
//

import SwiftUI

struct ViewCoordinator: View {
    
    @State var splashActive : Bool = false
    
    @AppStorage(AppStorageKeys.isOnboardCompleted.rawValue) var isOnboardCompleted = false
    
    var body: some View {
        if splashActive {
            if isOnboardCompleted {
                FolderHomeView()
            }else{
                OnboardView()
            }
        }else {
            SplashScreen(isActive: $splashActive)
        }
    }
}
