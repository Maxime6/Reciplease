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
    
    var ingredients = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsSettings()
    }
    
    func buttonsSettings() {
        addButton.layer.cornerRadius = 5
        addButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        addButton.layer.shadowColor = UIColor(ciColor: .black).cgColor
        addButton.layer.shadowRadius = 5
        addButton.layer.shadowOpacity = 0.3
        
        clearButton.layer.cornerRadius = 5
        clearButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        clearButton.layer.shadowColor = UIColor(ciColor: .black).cgColor
        clearButton.layer.shadowRadius = 5
        clearButton.layer.shadowOpacity = 0.3
        
        searchForRecipesButton.layer.cornerRadius = 5
        searchForRecipesButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        searchForRecipesButton.layer.shadowColor = UIColor(ciColor: .black).cgColor
        searchForRecipesButton.layer.shadowRadius = 5
        searchForRecipesButton.layer.shadowOpacity = 0.5
    }

    @IBAction func addIngredientButton() {
        guard let ingredient = ingredientsTextField.text else { return }
        if ingredient.isEmpty {
            displayAlert(title: "Warning", message: "Please enter an ingredient", preferredStyle: .alert)
        } else {
            ingredients.append(ingredient)
            ingredientsListTableView.reloadData()
            ingredientsTextField.text = ""
        }
        
    }
    
    @IBAction func clearIngredientsListButton(_ sender: Any) {
        ingredients.removeAll()
        ingredientsListTableView.reloadData()
    }
    
    @IBAction func searchingRecipesButton(_ sender: Any) {
        
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
