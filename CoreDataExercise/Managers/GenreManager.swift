//
//  GenreManager.swift
//  CoreDataExercise
//
//  Created by Agata Przykaza on 21/05/2025.
//

import Foundation
import CoreData


final class GenreManager{
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func create(name:String) throws -> Genre{
        let genre = Genre(context: context)
        genre.id = UUID().uuidString
        genre.name = name
        
        try context.save()
        
        return genre
    }
}

