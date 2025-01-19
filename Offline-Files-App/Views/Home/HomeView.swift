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
                if homeViewModel.folders.isEmpty {
                    VStack(spacing:15) {
                        Image(systemName: "folder.fill")
                            .font(.title)
                        Text("No folders")
                            .font(.poppins(.medium, size: 20))
                    }
                    .foregroundStyle(Color.appTextSecondary)
                    .frame(maxHeight: .infinity,alignment: .center)
                }else{
                    ScrollView(showsIndicators: false){
                        switch homeViewModel.folderDisplayType {
                        case .list:
                            FoldersListView(folders: $homeViewModel.folders) { folder in
                                homeViewModel.showFolderEditOptions(folder: folder)
                            }
                        case .grid:
                            FoldersGridView(folders: $homeViewModel.folders) { folder in
                                homeViewModel.showFolderEditOptions(folder: folder)
                            }
                        }
                    }
                    Spacer()
                }
            }
            .presentNewFolderView(isPresented: $homeViewModel.presentNewFolderNameView,
                                  folderName: $homeViewModel.newFolderName,
                                  isFav: $homeViewModel.isFavouriteFolder,
                                  folderColor: $homeViewModel.folderColor,
                                  confirmFolderAction: homeViewModel.folderAction)
        }
    }
}
