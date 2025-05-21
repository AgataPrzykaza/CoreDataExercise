//
//  Helper.swift
//  CoreDataExercise
//
//  Created by Agata Przykaza on 21/05/2025.
//
import CoreData

enum SeedDataService {
    
    static func deleteAll(in context: NSManagedObjectContext) throws {
        let entities = ["Book", "Author", "Genre"]
        
        for entityName in entities {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try context.execute(deleteRequest)
        }
        try context.save()
        print("🧹 Baza danych została wyczyszczona")
    }
    static func resetAndSeed(in context: NSManagedObjectContext) throws {
        try deleteAll(in: context)
        try populateIfNeeded(in: context)
    }

    /// Uruchom tylko, gdy baza nie ma jeszcze żadnych książek
    static func populateIfNeeded(in context: NSManagedObjectContext) throws {
        let bookRequest: NSFetchRequest<Book> = Book.fetchRequest()
        bookRequest.fetchLimit = 1
        
        // ✔️ Jeśli w bazie jest choć jedna książka – nie dodawaj nic
        let existing = try context.count(for: bookRequest)
        guard existing == 0 else { return }
        
        // MARK: - 1. GATUNKI
        let fantasy   = Genre(context: context); fantasy.id = UUID().uuidString; fantasy.name = "Fantasy"
        let sciFi     = Genre(context: context); sciFi.id   = UUID().uuidString; sciFi.name   = "Sci-Fi"
        let crime     = Genre(context: context); crime.id   = UUID().uuidString; crime.name   = "Kryminał"
        
        // MARK: - 2. AUTORZY
        let rowling   = Author(context: context); rowling.id   = UUID().uuidString; rowling.name   = "J.K. Rowling"
        let tolkien   = Author(context: context); tolkien.id   = UUID().uuidString; tolkien.name   = "J.R.R. Tolkien"
        let lem       = Author(context: context); lem.id       = UUID().uuidString; lem.name       = "Stanisław Lem"
        
        // MARK: - 3. KSIĄŻKI
        func addBook(_ title: String,
                     year: Int16,
                     read: Bool,
                     author: Author,
                     genre: Genre)
        {
            let book      = Book(context: context)
            book.id       = UUID().uuidString
            book.title    = title
            book.year     = year
            book.isRead   = read
            book.author   = author
            book.genre    = genre
        }
        
        addBook("Harry Potter i Kamień Filozoficzny", year: 1997, read: true,  author: rowling, genre: fantasy)
        addBook("Harry Potter i Czara Ognia",         year: 2000, read: false, author: rowling, genre: fantasy)
        addBook("Władca Pierścieni: Drużyna Pierścienia", year: 1954, read: true, author: tolkien, genre: fantasy)
        addBook("Solaris",            year: 1961, read: false, author: lem,     genre: sciFi)
        addBook("Śledztwo",           year: 1959, read: true,  author: lem,     genre: crime)
        
        try context.save()
        print("📚 Seed danych Core Data zakończony powodzeniem")
    }
}
