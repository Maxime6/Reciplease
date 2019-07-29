//
//  IngredientLine.swift
//  Reciplease
//
//  Created by Maxime on 17/07/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation
import CoreData

class IngredientLine: NSManagedObject {
    
    static func create(name: String, recipe: Recipe, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let favoriteIngredientLine = IngredientLine(context: viewContext)
        favoriteIngredientLine.name = name
        favoriteIngredientLine.recipe = recipe
    }
    
}
