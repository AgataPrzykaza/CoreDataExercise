//
//  SwiftUIView.swift
//  CoreDataExercise
//
//  Created by Agata Przykaza on 22/05/2025.
//

import SwiftUI

@Observable
class BookListViewModel{
    var books: [Book] = []
    
    func loadBooks(){
        
    }
}

struct BookListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var viewModel = BookListViewModel()
    
    var body: some View {
        List{
            ForEach(viewModel.books){ book in
                
                VStack{
                    Text(book.title!)
                    Text(book.author!.name!)
                    Text(String(book.year))
                }
                
                
            }
        }
    }
    
}

#Preview {
    BookListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    
}
