//
//  HomeView.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 10/01/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            Color.appBgPrimary
                .ignoresSafeArea()
            VStack(spacing:10) {
                NavigationHeader(headerTitle: .getAppName)
                    
                HStack{
                    WelcomeNoteView()
                    Spacer()
                    HomeEllipsisOptionsView(performAction: homeViewModel.performAction)
                }
                
                ScrollView(showsIndicators: false){
                    switch homeViewModel.folderDisplayType {
                    case .list:
                        FoldersListView(folders: $homeViewModel.folders)
                    case .grid:
                        FoldersGridView(folders: $homeViewModel.folders)
                    }
                }
            
                Spacer()
            }
            .fullScreenCover(isPresented: $homeViewModel.presentNewFolderNameView) {
                NewFolderNameView(folderName: $homeViewModel.newFolderName) {
                    print("new folder")
                    homeViewModel.createNewFolder()
                }
            }
        }
    }
}
