//
//  ContentView.swift
//  CoreDataExercise
//
//  Created by Agata Przykaza on 21/05/2025.
//

import SwiftUI
import CoreData




struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var books : [Book] = []
    
    
    @State private var bookManager: BookManager?
    @State private var authorManager: AuthorManager?
    @State private var genreManager: GenreManager?

    
     func loadBooks(){
        do{
            books = try bookManager!.fetchAll()
        } catch{
            print("Błąd pobierania książek: \(error.localizedDescription)")
                       
        }
    }
  
    var body: some View {
        NavigationView {
            List {
                
              
                
                ForEach(books) { book in
                    NavigationLink {
                        Text("Title: \(book.title!)")
                    } label: {
                        Text("Title: \(book.title ?? "brak")")
                    }
                }
                //.onDelete(perform: deleteItems)
            }
            .onAppear {
                if bookManager == nil {
                    bookManager = BookManager(context: viewContext)
                    authorManager = AuthorManager(context: viewContext)
                    genreManager = GenreManager(context: viewContext)
                }
                loadBooks()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addBook) {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addBook(){
        withAnimation {
            
            do{
                guard let author = try authorManager?.create(name: "J.K. Rowling"),
                      let genre = try genreManager?.create(name: "Fantasy") else { return }

                try bookManager?.create(title: "Harry Potter", year: 2001, author: author, genre: genre)
                loadBooks()

                loadBooks()
                
                
            }
            catch{
                print("Error creating book: \(error.localizedDescription)")
            }
            
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
