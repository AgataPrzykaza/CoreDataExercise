//
//  BooksByAuthorView.swift
//  CoreDataExercise
//
//  Created by Agata Przykaza on 21/05/2025.
//

import SwiftUI




struct BooksByAuthorView: View {
    var author: Author
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(DataManagerContainer.self) private var dataManager
    
   
   
    
    @FetchRequest private var books: FetchedResults<Book>

    init(author: Author) {
          
        _books = FetchRequest<Book>(
               sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true)],
               predicate: NSPredicate(format: "author == %@", author),
               animation: .default
           )
        
        self.author = author
       }
 
    
    func deleteBook(at offset: IndexSet){
        withAnimation {
            offset.map{books[$0]}.forEach { book in
                do {
                    try dataManager.bookManager.delete(book)
                } catch{
                    print("Błąd usuwania: \(error)")
                }
            }
            
           
        }
    }
    
    var body: some View {
        List{
            ForEach(books){ book in
                
                NavigationLink {
                    BookView(book: book)
                       
                } label: {
                    Text(book.title!)
                }

                
            }
            .onDelete(perform: deleteBook)
        }
        .navigationTitle(author.name!)
        
     
    }
}


