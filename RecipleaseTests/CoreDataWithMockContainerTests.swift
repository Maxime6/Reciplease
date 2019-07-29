//
//  CoreDataWithMockContainerTests.swift
//  RecipleaseTests
//
//  Created by Maxime on 16/07/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class CoredataWithMockContainerTests: XCTestCase {
    
    lazy var mockContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (description, error) in
            XCTAssertNil(error)
        })
        return container
    }()
    
    
    private func insertRecipeItem(into managedObjectContext: NSManagedObjectContext) {
        let newRecipeItem = Recipe(context: managedObjectContext)
        newRecipeItem.id = "id"
        newIngredient(into: managedObjectContext)
        newIngredientsLines(into: managedObjectContext)
    }
    
    private func newIngredient(into managedObjectContext: NSManagedObjectContext) {
        let ingredient = Ingredient(context: managedObjectContext)
        ingredient.name = "name"
    }

    private func newIngredientsLines(into managedObjectContext: NSManagedObjectContext) {
        let ingredientLine = IngredientLine(context: managedObjectContext)
        ingredientLine.name = "ingredientLine name"
    }
    
    func testInsertManyRecipeItemsInPersistentContainer() {
        for _ in 0..<10000 {
            insertRecipeItem(into: mockContainer.newBackgroundContext())
        }
        XCTAssertNoThrow(try mockContainer.newBackgroundContext().save())
    }
    
    func testDeleteIteminPersistentContainer() {
        insertRecipeItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        Recipe.delete(id: "id", viewContext: mockContainer.viewContext)
        XCTAssertEqual(Recipe.fetchAll(viewContext: mockContainer.viewContext), [])
    }
    
    func testIsRegisteredInPersistentContainer() {
        insertRecipeItem(into: mockContainer.viewContext)
        try? mockContainer.viewContext.save()
        let isRegistered = Recipe.isRegistered(id: "id", viewContext: mockContainer.viewContext)
        XCTAssertEqual(isRegistered, true)
    }
    
    func testIsNotRegisteredInPersistentContainer() {
        try? mockContainer.viewContext.save()
        let isRegistered = Recipe.isRegistered(id: "id", viewContext: mockContainer.viewContext)
        XCTAssertEqual(isRegistered, false)
    }
    
    func testCreateIngredientEntityInPersistentContainer() {
//        let recipe = Recipe(context: mockContainer.viewContext)
//        newIngredient(into: mockContainer.viewContext)
////        let ingredient = Ingredient(context: mockContainer.viewContext)
////        ingredient.name = "name"
//        Ingredient.create(name: "name", recipe: recipe, viewContext: mockContainer.viewContext)
//
//        XCTAssertEqual(recipe, recipe)
        
        
    }
    
    func testCreateEntityInPersistentContainer() {
        let ingredient = ["salad", "chicken"]
        let ingredientLines = ["2 scoop", "3 recipe"]
        let sourceDecodable = SourceDecodable(sourceRecipeUrl: "url")
        let recipeImageDecodable = [RecipeImageDecodable(hostedLargeUrl: "image url")]
        let recipeDetailsData = RecipeDetailsData(id: "id", name: "recipe name", ingredientLines: ingredientLines, source: sourceDecodable, totalTimeInSeconds: 200, rating: 4, images: recipeImageDecodable)
        Recipe.create(recipeDetailsData: recipeDetailsData, ingredients: ingredient, viewContext: mockContainer.viewContext)
        
        let recipe = Recipe.fetchAll(viewContext: mockContainer.viewContext).first
        XCTAssertNotNil(recipe)
        XCTAssertEqual(recipe?.name!, "recipe name")
        XCTAssertEqual(recipe?.id!, "id")
        
       
        
//        XCTAssertNotEqual(Recipe.fetchAll(viewContext: mockContainer.viewContext), [Recipe])
        
    }

}
