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

    init(){
        if let url = persistenceController.container.persistentStoreCoordinator.persistentStores.first?.url {
                   print("🗂 Baza Core Data zapisuje się tutaj: \(url.path)")
               }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
