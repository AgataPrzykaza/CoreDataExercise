//
//  TabView.swift
//  CoreDataExercise
//
//  Created by Agata Przykaza on 21/05/2025.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
       
        TabView {
            Tab("Authors",systemImage: "person"){
                AuthorListView()
            }
            
            Tab("Books",systemImage: "book"){
                Text("Books")
            }
        }
        
        
    }
}

#Preview {
    TabsView()
}
