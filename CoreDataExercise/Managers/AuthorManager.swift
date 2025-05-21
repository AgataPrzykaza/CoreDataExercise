//
//  AuthorManager.swift
//  CoreDataExercise
//
//  Created by Agata Przykaza on 21/05/2025.
//
import Foundation
import CoreData

final class AuthorManager{
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func create(name:String) throws -> Author{
        let author = Author(context: context)
        author.id = UUID().uuidString
        author.name = name
        
        try context.save()
        return author
    }
    
    func fetchAll() throws-> [Author]{
        
        let request: NSFetchRequest<Author> = Author.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Author.name, ascending: true)]
        
        return try context.fetch(request)
        
    }
    
}
