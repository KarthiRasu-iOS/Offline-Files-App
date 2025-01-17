//
//  HomeView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 10/01/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var gridItems = Array(repeating: GridItem(), count: 3)
    
    var body: some View {
        ZStack {
            Color.appBgPrimary
                .ignoresSafeArea()
            VStack {
                NavigationHeader(headerTitle: .getAppName)
                HStack{
                    WelcomeNoteView()
                    Spacer()
                    HomeEllipsisOptionsView {
                        homeViewModel.createNewFolder()
                    }
                }
                
                ScrollView {
                    LazyVGrid(columns: gridItems) {
                        ForEach(homeViewModel.folders) { folder in
                            Image(.splashIcon)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}
