//
//  BookView.swift
//  CoreDataExercise
//
//  Created by Agata Przykaza on 22/05/2025.
//

import SwiftUI

struct EditSheetView: View {
    
    @Environment(DataManagerContainer.self) private var dataManager
    
    @ObservedObject var book: Book
    @Binding var showEditView: Bool
    
    @State private var title: String = ""
    @State private var year: String = ""
    @State private var isRead: Bool = false
    
    private func saveChanges() {
        do {
            try dataManager.bookManager.update(
                book: book,
                title: title,
                year: Int16(year) ?? book.year,
                isRead: isRead
            )
        } catch {
            print("Błąd zapisu książki: \(error)")
        }
    }

    
    var body: some View {
        
        NavigationStack {
            Form {
                Section(header: Text("Informacje o książce")) {
                    TextField("Tytuł", text: $title)
                    TextField("Rok wydania", text: $year)
                        .keyboardType(.numberPad)
                    Toggle("Przeczytana", isOn: $isRead)
                }
                
                
            }
            .navigationTitle("Edytuj książkę")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Anuluj") {
                        showEditView = false
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Zapisz") {
                        saveChanges()
                        showEditView = false
                    }
                }
            }
            .onAppear {
                title = book.title ?? ""
                year = String(book.year)
                isRead = book.isRead
                
            }
           

        }
    }
}
struct BookView: View {
   @ObservedObject var book: Book
    @State var showEditView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text(book.title!)
                .font(.title)
            Text((book.author?.name)!)
                .bold()
            Text((book.genre?.name)!)
            Text("Year:\(book.year)")

        }
        .padding()
        .frame(maxWidth: .infinity,alignment: .center)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                
                Button {
                  
                        showEditView = true
                    
                } label: {
                    Text("Edit")
                }

                
            }
        }
        .fullScreenCover(isPresented: $showEditView) {
            EditSheetView(book: book, showEditView: $showEditView)
        }
        
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
       
       let book = Book(context: context)
       book.title = "Władca Pierścieni"
       book.year = 1954
       let author = Author(context: context)
       author.name = "J.R.R. Tolkien"
       book.author = author
       let genre = Genre(context: context)
       genre.name = "Fantasy"
       book.genre = genre

    return BookView(book: book)
    
}
