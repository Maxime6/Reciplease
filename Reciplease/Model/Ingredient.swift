//
//  Ingredient.swift
//  Reciplease
//
//  Created by Maxime on 18/06/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation
import CoreData

class Ingredient: NSManagedObject {
    
    static func create(name: String, recipe: Recipe, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let favoriteIngredient = Ingredient(context: viewContext)
        favoriteIngredient.name = name
        favoriteIngredient.recipe = recipe
    }
    
}
