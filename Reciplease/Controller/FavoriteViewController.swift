//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Maxime on 09/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    var recipesData: RecipesData?
    var favoriteRecipesList = Recipe.fetchAll()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(favoriteRecipesList)

    }

}

extension FavoriteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteRecipeCell", for: indexPath) as? CustomRecipeTableViewCell else { return UITableViewCell() }
//        guard let recipeData = recipesData else { return UITableViewCell() }
//        cell.
        return cell
    }
    
    
}
