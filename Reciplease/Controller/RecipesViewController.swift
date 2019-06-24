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
    var recipeData: RecipesData?
    var recipeDetailsData: RecipeDetailsData?
    var ingredients = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reciplease"
        
    }
    
    
    func networkCall(indexPath: IndexPath) {
        guard let recipeId = recipeData?.matches[indexPath.row].id else { return }
        yummlyService.getDetailsRecipes(recipeId: recipeId) { (success, recipeDetailsData) in
            if success, let recipeDetailsData = recipeDetailsData {
                self.recipeDetailsData = recipeDetailsData
                self.performSegue(withIdentifier: "segueToDetails", sender: self)
            } else {
                self.displayAlert(title: "Error", message: "Details not found, please try again later.", preferredStyle: .alert)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetails" {
            let detailsOfRecipesVC = segue.destination as! DetailsOfRecipeViewController
            detailsOfRecipesVC.recipeDetailsData = recipeDetailsData
        }
    }

}

extension RecipesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipeData = recipeData else { return 0 }
        return recipeData.matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? CustomRecipeTableViewCell else {
            return UITableViewCell()
        }
        guard let recipeData = recipeData else { return UITableViewCell() }
        cell.recipe = recipeData.matches[indexPath.row]
        return cell
    }
    
}

extension RecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        networkCall(indexPath: indexPath)
    }
    
}
