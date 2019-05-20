//
//  GetRecipesData.swift
//  Reciplease
//
//  Created by Maxime on 07/05/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation

struct RecipeDetailsData: Decodable {
    let id: String
    let name: String
    let ingredientLines: [String]
    let source: SourceDecodable
    let totalTimeInSeconds: Int
    let rating: Int
    let images: [RecipeImageDecodable]
}

struct SourceDecodable: Decodable {
    let sourceRecipeUrl: String
}

struct RecipeImageDecodable: Decodable {
    var hostedLargeUrl: String?
}
