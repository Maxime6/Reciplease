//
//  YummlySession.swift
//  Reciplease
//
//  Created by Maxime on 07/05/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation
import Alamofire

class YummlySession: YummlyProtocol {
    var searchRecipeUrlStringApi: String = "http://api.yummly.com/v1/api/recipes?_app_id=2950fd7a&_app_key=add59c6e7af7f6a536274bad7db485b6"
    var getRecipeUrlStringApi: String = "http://api.yummly.com/v1/api/recipe?_app_id=2950fd7a&_app_key=add59c6e7af7f6a536274bad7db485b6"
    
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { (responsData) in
            completionHandler(responsData)
        }
    }
    
//    func imageRequest(url: URL, completionHandler: @escaping (DataResponse<Data>) -> Void) {
//        Alamofire.request(url).responseData { (responseData) in
//            completionHandler(responseData)
//        }
//    }
    
    func buildRequest(ingredients: [String]) {
        // ajouter les ingrédient allowedIngredients a urlStringApi
        let allowedIngredients = ingredients
        for ingredient in allowedIngredients {
            guard let parameter = "&allowedIngredient[]=\(ingredient)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
            searchRecipeUrlStringApi += parameter
        }
    }
    
    func buildDetailRequest(recipeId: String) {
        guard let recipeId = recipeId.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        getRecipeUrlStringApi = "http://api.yummly.com/v1/api/recipe/\(recipeId)?_app_id=2950fd7a&_app_key=add59c6e7af7f6a536274bad7db485b6"
    }
    
}
