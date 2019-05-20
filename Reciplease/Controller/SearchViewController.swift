//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Maxime on 09/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var ingredientsListTableView: UITableView!
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchForRecipesButton: UIButton!
    @IBOutlet weak var searchingRecipesActivityIndicator: UIActivityIndicatorView!
    
    var ingredients = [String]()
    let yummlyService = YummlyService()
    var recipeData: RecipesData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsSettings(buttons: [addButton, clearButton, searchForRecipesButton])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchForRecipesButton.isHidden = false
        searchingRecipesActivityIndicator.isHidden = true
    }
    
    func buttonsSettings(buttons: [UIButton]) {
        for button in buttons {
            button.layer.cornerRadius = 5
            button.layer.shadowOffset = CGSize(width: 0, height: 3)
            button.layer.shadowColor = UIColor(ciColor: .black).cgColor
            button.layer.shadowRadius = 5
            button.layer.shadowOpacity = 0.3
        }
        
    }

    @IBAction func addIngredientButton() {
        guard let ingredientsText = ingredientsTextField.text else { return }
        
        if ingredientsText.isEmpty {
            displayAlert(title: "Warning", message: "Please enter an ingredient", preferredStyle: .alert)
        } else {
            ingredients += ingredientsText.transformToArrayWithoutPonctuation
            ingredientsListTableView.reloadData()
            ingredientsTextField.text = ""
        }
        
    }
    
    @IBAction func clearIngredientsListButton(_ sender: Any) {
        ingredients.removeAll()
        ingredientsListTableView.reloadData()
    }
    
    @IBAction func searchingRecipesButton(_ sender: Any) {
        if ingredients.isEmpty == true {
            displayAlert(title: "Warning", message: "Please enter one or more ingredients to find recipes.", preferredStyle: .alert)
        } else {
            searchForRecipesButton.isHidden = true
            searchingRecipesActivityIndicator.isHidden = false
            networkCall()
        }
        
    }
    
    func networkCall() {
        yummlyService.getRecipes(ingrdients: ingredients) { (success, recipesData) in
            if success, let recipesData = recipesData {
                self.recipeData = recipesData
                self.performSegue(withIdentifier: "segueToRecipes", sender: self)
            } else {
                self.displayAlert(title: "Error", message: "Recipes can not be found, please try again later.", preferredStyle: .alert)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipes" {
            let recipesVC = segue.destination as! RecipesViewController
            recipesVC.recipeData = recipeData
        }
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = "- " + ingredient
        return cell
    }
    
    
}

