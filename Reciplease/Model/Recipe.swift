//
//  Recipe.swift
//  Reciplease
//
//  Created by Maxime on 23/05/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation
import CoreData

class Recipe: NSManagedObject {
    
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        guard let recipes = try? viewContext.fetch(request) else { return [] }
        return recipes
    }
    
//    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
//        Recipe.fetchAll(viewContext: viewContext).forEach({ viewContext.delete($0) })
//        try? viewContext.save()
//    }
    
}
