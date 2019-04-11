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
    
    var ingredients = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addIngredientButton() {
        guard let ingredient = ingredientsTextField.text else { return }
        ingredients.append(ingredient)
        ingredientsListTableView.reloadData()
        ingredientsTextField.text = ""
    }
    
    @IBAction func clearIngredientsListButton(_ sender: Any) {
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
