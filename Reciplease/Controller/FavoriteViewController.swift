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
    
    //MARK: - Outlets
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    //MARK: - Properties
    
    private var favoriteRecipeData: Recipe?
    private var favoriteRecipesList = Recipe.fetchAll()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredRecipes = [Recipe]()

    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.register(UINib(nibName: "CustomRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search recipes"
        navigationItem.searchController = searchController
        searchController.searchBar.barStyle = .blackOpaque
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteRecipesList = Recipe.fetchAll()
        favoritesTableView.reloadData()
    }
    
    //MARK: - Class Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFavoritesToDetails" {
            let detailsOfRecipesVC = segue.destination as! DetailsOfRecipeViewController
            detailsOfRecipesVC.isFavorite = true
            detailsOfRecipesVC.favoriteRecipeData = favoriteRecipeData
        }
    }
    
    // Check if searchBar is empty
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    // Filter recipes by searchText
    private func filterContentForSearchText(_ searchText: String) {
        filteredRecipes = favoriteRecipesList.filter({ (recipe: Recipe) -> Bool in
            guard let name = recipe.name else { return false }
            return name.lowercased().contains(searchText.lowercased())
        })
        favoritesTableView.reloadData()
    }
    
    // Check if user is filtering his recipes
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

}

//MARK: - TableView DataSource

extension FavoriteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredRecipes.count
        }
        return favoriteRecipesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? CustomRecipeTableViewCell else { return UITableViewCell() }
        var favoriteRecipe: Recipe
        if isFiltering() {
            favoriteRecipe = filteredRecipes[indexPath.row]
        } else {
            favoriteRecipe = favoriteRecipesList[indexPath.row]
        }
        cell.favoriteRecipe = favoriteRecipe
        return cell
    }
    
}

//MARK: - TableView Delegate

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        favoriteRecipeData = favoriteRecipesList[indexPath.row]
        performSegue(withIdentifier: "segueFavoritesToDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
    
}

//MARK: - SearchBar Results Updating

extension FavoriteViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filterContentForSearchText(searchText)
    }
}
