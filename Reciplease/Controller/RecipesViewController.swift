//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Maxime on 10/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var recipesTableView: UITableView!
    
    //MARK: - Properties
    
    private let yummlyService = YummlyService()
    var recipesData: RecipesData?
    private var recipeDetailsData: RecipeDetailsData?
    private var ingredients = [String]()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reciplease"
        recipesTableView.register(UINib(nibName: "CustomRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        
    }
    
    //MARK: - Class Methods
    
    // Network call to display details of recipes
    private func networkCall(indexPath: IndexPath) {
        guard let recipeId = recipesData?.matches[indexPath.row].id else { return }
        yummlyService.getDetailsRecipes(recipeId: recipeId) { (success, recipeDetailsData) in
            if success, let recipeDetailsData = recipeDetailsData {
                self.recipeDetailsData = recipeDetailsData
                self.ingredients = self.recipesData?.matches[indexPath.row].ingredients ?? []
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
            detailsOfRecipesVC.ingredients = ingredients
            detailsOfRecipesVC.isFavorite = false
        }
    }

}

//MARK: - TableView DataSource

extension RecipesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipeData = recipesData else { return 0 }
        return recipeData.matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? CustomRecipeTableViewCell else {
            return UITableViewCell()
        }
        guard let recipeData = recipesData else { return UITableViewCell() }
        cell.recipe = recipeData.matches[indexPath.row]
        return cell
    }
    
}

//MARK: - TableView Delegate

extension RecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        networkCall(indexPath: indexPath)
    }
    
}
