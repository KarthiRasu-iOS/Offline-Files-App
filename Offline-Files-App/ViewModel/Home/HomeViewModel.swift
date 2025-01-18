//
//  HomeViewModel.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 17/01/25.
//

import SwiftUI
import CoreData

class HomeViewModel : ObservableObject {
    
    @Published var folderDisplayType : FolderType = .grid
    
    @Published var folders : [FoldersEntity] = []
    
    @Published var presentNewFolderNameView : Bool = false
    
    @Published var newFolderName : String = ""
    
    init() {
        fetchFolders()
    }
    
    let persistence = PersistenceController.shared

    
    func performAction(_ action:MenuActions){
        switch action {
        case .newFolder:
            presentNewFolderNameView.toggle()
        case .list:
            folderDisplayType = .list
        case .grid:
            folderDisplayType = .grid
        case .sort:
            break
        }
    }
}


//MARK: - Folder Actions

extension HomeViewModel {
    
    func fetchFolders() {
        let folderFetchRequest = NSFetchRequest<FoldersEntity>(entityName: Entities.folder.rawValue)
        do {
            folders = try persistence.container.viewContext.fetch(folderFetchRequest)
        }catch{
            print("error in fetching folder",error.localizedDescription)
        }
    }
    
    func createNewFolder() {
        let newFolder = FoldersEntity(context: persistence.container.viewContext)
        newFolder.referenceid = UUID().uuidString
        newFolder.name = newFolderName
        newFolder.createdTimestamp = Date().timeIntervalSince1970.description
        persistence.saveChanges()
        fetchFolders()
    }
}
