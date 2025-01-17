//
//  Persistence.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 09/01/25.
//

import CoreData

enum Entities : String {
    case folder = "FoldersEntity"
    case files = "FilesEntity"
}

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Offline_Files_App")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveChanges() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error in saving Core Data changes")
        }
    }
}
