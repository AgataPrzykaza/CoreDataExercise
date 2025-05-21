//
//  TabView.swift
//  CoreDataExercise
//
//  Created by Agata Przykaza on 21/05/2025.
//

import SwiftUI

struct TabsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
       
        TabView {
            Tab("Authors",systemImage: "person"){
                NavigationStack{
                    AuthorListView()
                }
            }
            
            Tab("Books",systemImage: "book"){
                Text("Books")
            }
        }
      
        
        
    }
}

#Preview {
    TabsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
