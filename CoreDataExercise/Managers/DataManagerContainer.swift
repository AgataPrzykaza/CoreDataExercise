//
//  DataManagerContainer.swift
//  CoreDataExercise
//
//  Created by Agata Przykaza on 22/05/2025.
//
import CoreData

@Observable
final class DataManagerContainer {
    let bookManager: BookManager
    let authorManager: AuthorManager
    let gerneManager: GenreManager
   
    init(context: NSManagedObjectContext) {
        self.bookManager = BookManager(context: context)
        self.authorManager = AuthorManager(context: context)
        self.gerneManager = GenreManager(context: context)
    }
}
