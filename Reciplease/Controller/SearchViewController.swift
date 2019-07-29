//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Maxime on 09/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var ingredientsListTableView: UITableView!
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchForRecipesButton: UIButton!
    @IBOutlet weak var searchingRecipesActivityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    
    private var ingredients = [String]()
    private let yummlyService = YummlyService()
    private var recipeData: RecipesData?
    
    // MARK: - View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsSettings(buttons: [addButton, clearButton, searchForRecipesButton])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchForRecipesButton.isHidden = false
        searchingRecipesActivityIndicator.isHidden = true
    }

    //MARK: - Actions
    
    @IBAction func addIngredientButton() {
        guard let ingredientsText = ingredientsTextField.text else { return }
        
        if ingredientsText.isEmpty {
            displayAlert(title: "Warning", message: "Please enter an ingredient", preferredStyle: .alert)
        } else {
            ingredients += ingredientsText.transformToArrayWithoutPonctuation
            ingredientsListTableView.reloadData()
            ingredientsTextField.text = ""
        }
        
        ingredientsTextField.resignFirstResponder()
        
    }
    
    @IBAction func clearIngredientsListButton(_ sender: Any) {
        ingredients.removeAll()
        ingredientsListTableView.reloadData()
        searchForRecipesButton.isHidden = false
        searchingRecipesActivityIndicator.isHidden = true
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
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ingredientsTextField.resignFirstResponder()
    }
    
    //MARK: - Class Methods
    
    private func buttonsSettings(buttons: [UIButton]) {
        for button in buttons {
            button.layer.cornerRadius = 5
            button.layer.shadowOffset = CGSize(width: 0, height: 3)
            button.layer.shadowColor = UIColor(ciColor: .black).cgColor
            button.layer.shadowRadius = 5
            button.layer.shadowOpacity = 0.3
        }
        
    }
    
    // Network call to find recipes
    private func networkCall() {
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
            recipesVC.recipesData = recipeData
        }
    }
    
}

//MARK: - TableView DataSource

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

//MARK: - TextField Delegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

