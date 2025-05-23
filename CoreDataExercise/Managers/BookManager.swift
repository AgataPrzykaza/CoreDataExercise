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
    
    func fetchForAuthor(author: Author) throws -> [Book]{
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        request.predicate = NSPredicate(format: "author == %@", author)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Book.title, ascending: true)]
        
        return try context.fetch(request)
    }
    
    func update(
        book: Book,
        title: String? = nil,
        year: Int16? = nil,
        isRead: Bool? = nil,
        author: Author? = nil,
        genre: Genre? = nil
    ) throws -> Book{
        if let title = title {
            book.title = title
        }
        if let year = year {
            book.year = year
        }
        if let isRead = isRead {
            book.isRead = isRead
        }
        if let author = author {
            book.author = author
        }
        if let genre = genre {
            book.genre = genre
        }

        try context.save()
        return book
    }

    
    func delete(_ book: Book) throws{
        context.delete(book)
        try context.save()
    }
    
}
