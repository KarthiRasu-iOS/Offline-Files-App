//
//  Offline_Files_AppApp.swift
//  Offline-Files-App
//
//  Created by Karthi Rasu on 09/01/25.
//

import SwiftUI

@main
struct Offline_Files_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ViewCoordinator()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(OrientationInfo())
        }
    }
}
