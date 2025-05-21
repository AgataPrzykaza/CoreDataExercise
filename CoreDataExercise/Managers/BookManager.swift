//
//  BookManager.swift
//  CoreDataExercise
//
//  Created by Agata Przykaza on 21/05/2025.
//

import Foundation
import CoreData

final class BookManager{
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func create(title: String,year: Int16,isRead: Bool = false,author: Author,genre: Genre) throws -> Book{
        
        let book = Book(context: context)
        book.id = UUID().uuidString
        book.title = title
        book.year = year
        book.isRead = isRead
        book.author = author
        book.genre = genre
        
        try context.save()
        
        return book

    }
    
    func fetchAll() throws-> [Book]{
        
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Book.title, ascending: true)]
        
        return try context.fetch(request)
        
    }
    
    
    
    
    
}
