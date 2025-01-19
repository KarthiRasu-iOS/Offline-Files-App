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
    @Published var isFavouriteFolder : Bool = false
    @Published var folderColor : Color = .appTheme
    
    var onEditFolderIndex : Int?
    
    var isEditModeOn : Bool = false
    
    @Published var folderSortingOrder : FolderSortingOrder = .ascending
    
    init() {
        fetchFolders()
    }
    
    let persistence = PersistenceController.shared

    
    func performAction(_ action:MenuActions){
        switch action {
        case .newFolder:
            clearFolderValues()
            presentNewFolderNameView.toggle()
        case .list:
            folderDisplayType = .list
        case .grid:
            folderDisplayType = .grid
        case .sortbyname:
            folderSortingOrder = folderSortingOrder == .ascending ? .descending : .ascending
            sortFolderDisplayOrder()
        case .sortbycreationdate :
            folderSortingOrder = folderSortingOrder == .creationDateAsc ? .creationDateDes : .creationDateAsc
            sortFolderDisplayOrder()
        }
    }
}


//MARK: - Folder Actions

extension HomeViewModel {
    
    private func fetchFolders() {
        let folderFetchRequest = NSFetchRequest<FoldersEntity>(entityName: Entities.folder.rawValue)
        folderFetchRequest.sortDescriptors = [getSortingQuery()]
        do {
            folders = try persistence.container.viewContext.fetch(folderFetchRequest)
        }catch{
            print("error in fetching folder",error.localizedDescription)
        }
    }
    
    func folderAction() {
        if isEditModeOn {
            updateFolder()
        }else{
            createNewFolder()
        }
    }
    
    private func createNewFolder() {
        let newFolder = FoldersEntity(context: persistence.container.viewContext)
        newFolder.referenceid = UUID().uuidString
        newFolder.name = newFolderName
        newFolder.isFavourite = isFavouriteFolder
        newFolder.tag = folderColor.toHexString()
        newFolder.createdTimestamp = Date().timeIntervalSince1970.description
        persistence.saveChanges()
        fetchFolders()
        newFolderName = ""
    }
    
    private func updateFolder() {
        if let updateIndex =  onEditFolderIndex {
            let folder = folders[updateIndex]
            folder.name = newFolderName
            folder.isFavourite = isFavouriteFolder
            folder.tag = folderColor.toHexString()
            persistence.saveChanges()
        }
    }
}

//MARK: - Sorting

extension HomeViewModel {
    func sortFolderDisplayOrder() {
        if !folders.isEmpty {
            switch folderSortingOrder {
            case .ascending :
                withAnimation {
                    folders.sort{ a, b in
                        return a.name ?? "" < b.name ?? ""
                    }
                }
            case .descending :
                withAnimation {
                    folders.sort{ a, b in
                        return a.name ?? "" > b.name ?? ""
                    }
                }

            case .creationDateAsc :
                
                withAnimation {
                    folders.sort { a, b in
                        return a.createdTimestamp ?? "" < b.createdTimestamp ?? ""
                    }
                }
                
            case .creationDateDes :
                withAnimation {
                    folders.sort { a, b in
                        return a.createdTimestamp ?? "" > b.createdTimestamp ?? ""
                    }
                }
            }
        }
    }
    
    func getSortingQuery() -> NSSortDescriptor {
        if folderSortingOrder == .ascending || folderSortingOrder == .descending {
            return NSSortDescriptor(key: "name", ascending: folderSortingOrder == .ascending)
        }else if folderSortingOrder == .creationDateAsc || folderSortingOrder == .creationDateDes {
            return NSSortDescriptor(key: "createdTimestamp", ascending: folderSortingOrder == .creationDateAsc)
        }else{
            return NSSortDescriptor(key: "name", ascending: true)
        }
    }
}


//MARK: - Folder View

extension HomeViewModel {
    func showFolderEditOptions(folder:FoldersEntity){
        onEditFolderIndex = folders.firstIndex(of: folder)
        newFolderName = folder.name ?? ""
        isFavouriteFolder = folder.isFavourite
        if let colorTag = folder.tag {
            folderColor = Color.init(hex: colorTag) ?? .appTheme
        }else{
            folderColor = .appTheme
        }
        isEditModeOn = true
        presentNewFolderNameView = true
    }
    
    func clearFolderValues() {
        newFolderName = ""
        isFavouriteFolder = false
        isEditModeOn = false
        onEditFolderIndex = nil
        folderColor = .appTheme
    }
}
