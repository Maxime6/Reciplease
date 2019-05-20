//
//  RecipesData.swift
//  Reciplease
//
//  Created by Maxime on 17/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation

struct RecipesData: Decodable {
    let matches: [Match]
}

struct Match: Decodable {
    let id: String
    let recipeName: String
    let ingredients: [String]
    let totalTimeInSeconds: Int
    let rating: Int
    var smallImageUrls: [String]?
}

