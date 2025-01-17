//
//  HomeViewModel.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 17/01/25.
//

import SwiftUI
import CoreData

class HomeViewModel : ObservableObject {
    
    @Published var folders : [FoldersEntity] = []
    
    init() {
        fetchFolders()
    }
    
    let persistence = PersistenceController.shared
    
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
        newFolder.name = "New Folder"
        newFolder.createdTimestamp = Date().timeIntervalSince1970.description
        persistence.saveChanges()
        fetchFolders()
    }
}
