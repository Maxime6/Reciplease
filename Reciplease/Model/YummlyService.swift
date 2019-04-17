//
//  YummlyService.swift
//  Reciplease
//
//  Created by Maxime on 17/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation

class YummlyService {
    
    private var yummlySession: YummlySession
    
    init(yummlySession: YummlySession = YummlySession()) {
        self.yummlySession = yummlySession
    }
    
    func getRecipes(completionHandler: @escaping (Bool, RecipesData?) -> Void) {
        let url = URL(string: yummlySession.urlStringApi)!
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
    
}
