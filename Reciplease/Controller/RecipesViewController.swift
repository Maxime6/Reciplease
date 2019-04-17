//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Maxime on 10/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {
    
    let yummlyService = YummlyService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func networkCall() {
        yummlyService.getRecipes { (success, recipesData) in
            if success, let recipesData = recipesData {
                
            } else {
                self.displayAlert(title: "Error", message: "Recipes can not be found, please try again later.", preferredStyle: .alert)
            }
        }
    }

}

extension RecipesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
}
