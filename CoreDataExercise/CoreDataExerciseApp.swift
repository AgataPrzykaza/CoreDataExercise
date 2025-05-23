//
//  CoreDataExerciseApp.swift
//  CoreDataExercise
//
//  Created by Agata Przykaza on 21/05/2025.
//

import SwiftUI

@main
struct CoreDataExerciseApp: App {
    let persistenceController = PersistenceController.shared
    let dataManagers: DataManagerContainer

    init(){
//        if let url = persistenceController.container.persistentStoreCoordinator.persistentStores.first?.url {
//                   print("🗂 Baza Core Data zapisuje się tutaj: \(url.path)")
//               }
        
        dataManagers = DataManagerContainer(context: persistenceController.container.viewContext)
        
      
    }
    var body: some Scene {
        WindowGroup {
            TabsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(dataManagers)
        }
    }
}
