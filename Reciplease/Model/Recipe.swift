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
    
    // Delete entity
    static func delete(id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        guard let recipes = try? viewContext.fetch(request) else { return }
        guard let recipe = recipes.first else { return }
        viewContext.delete(recipe)
        try? viewContext.save()
    }
    
    // Check if entity is registered
    static func isRegistered(id: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> Bool {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        guard let recipes = try? viewContext.fetch(request) else { return false }
        if recipes.isEmpty {
            return false
        }
        return true
    }
    
    // Create an entity
    static func create(recipeDetailsData: RecipeDetailsData, ingredients: [String], viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let favoriteRecipe = Recipe(context: viewContext)
        favoriteRecipe.id = recipeDetailsData.id
        favoriteRecipe.url = recipeDetailsData.source.sourceRecipeUrl
        favoriteRecipe.name = recipeDetailsData.name
        favoriteRecipe.rating = recipeDetailsData.rating.description
        let time = recipeDetailsData.totalTimeInSeconds
        favoriteRecipe.time = ((time)/60).description
        favoriteRecipe.image = recipeDetailsData.images[0].hostedLargeUrl?.data
        for ingredient in ingredients {
            Ingredient.create(name: ingredient, recipe: favoriteRecipe, viewContext: viewContext)
        }
        for ingredientLine in recipeDetailsData.ingredientLines {
            IngredientLine.create(name: ingredientLine, recipe: favoriteRecipe, viewContext: viewContext)
        }
        try? viewContext.save()
    }
    
}
