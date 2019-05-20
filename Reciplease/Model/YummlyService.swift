//
//  YummlyService.swift
//  Reciplease
//
//  Created by Maxime on 07/05/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation
class YummlyService {
    
    private var yummlySession: YummlySession
    var recipe: Match?
    
    init(yummlySession: YummlySession = YummlySession()) {
        self.yummlySession = yummlySession
    }
    
    func getRecipes(ingrdients: [String], completionHandler: @escaping (Bool, RecipesData?) -> Void) {
        yummlySession.buildRequest(ingredients: ingrdients)
        guard let url = URL(string: yummlySession.searchRecipeUrlStringApi) else { return }
        yummlySession.request(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            guard let recipesData = try? JSONDecoder().decode(RecipesData.self, from: data) else {
                completionHandler(false, nil)
                return
            }
            completionHandler(true, recipesData)
        }
    }
    
    func getDetailsRecipes(recipeId: String, completionHandler: @escaping (Bool, RecipeDetailsData?) -> Void) {
        yummlySession.buildDetailRequest(recipeId: recipeId)
        guard let url = URL(string: yummlySession.getRecipeUrlStringApi) else { return }
        yummlySession.request(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            guard let recipeDetailsData = try? JSONDecoder().decode(RecipeDetailsData.self, from: data) else {
                completionHandler(false, nil)
                return
            }
            completionHandler(true, recipeDetailsData)
        }
    }
    
    func getImagesData(completionHandler: @escaping (Data?) -> Void) {
        guard let imageUrl = recipe?.smallImageUrls?[0] else { return }
        guard let url = URL(string: imageUrl) else { return }
        yummlySession.imageRequest(url: url, completionHandler: { (responseData) in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(nil)
                return
            }
            guard let imageData = try? JSONDecoder().decode(Data.self, from: data) else {
                completionHandler(nil)
                return
            }
            completionHandler(imageData)
        })
    }
    
}

