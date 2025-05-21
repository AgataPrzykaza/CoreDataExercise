//
//  AuthorListView.swift
//  CoreDataExercise
//
//  Created by Agata Przykaza on 21/05/2025.
//

import SwiftUI

struct AuthorListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var authors: [Author] = []
    @State private var authorManager: AuthorManager?
    
    var body: some View {
        List{
            ForEach(authors){ author in
                
                NavigationLink {
                    Text("author")
                } label: {
                    Text(author.name ?? "Brak nazwiska")
                }

                
            }
        }
        .navigationTitle("Autorzy")
        .onAppear{
            if authorManager == nil{
                authorManager = AuthorManager(context: viewContext)
            }
        }
    }
    
    
    func loadAuthors(){
        do{
            authors = try authorManager?.fetchAll() ?? []
        } catch{
            print("Error fetching authors: \(error)")
        }
    }
}

#Preview {
    AuthorListView()
}
