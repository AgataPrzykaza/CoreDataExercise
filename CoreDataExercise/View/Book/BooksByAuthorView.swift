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
    
    @State private var books: [Book] = []
    @State private var bookManager: BookManager?
    
    func loadBooks() {
        guard let bookManager = bookManager else { return }
        
        do {
           books =  try  bookManager.fetchForAuthor(author: author)
        } catch {
            print("Error while fetching books for author \(error.localizedDescription)")
        }
      
    }
    
    
    var body: some View {
        List{
            ForEach(books){ book in
                
                Text(book.title!)
                
            }
        }
        .navigationTitle(author.name!)
        .onAppear{
            if bookManager == nil {
                bookManager = BookManager(context: viewContext)
            }
            loadBooks()
            
        }
    }
}


