//
//  DetailsOfRecipeViewController.swift
//  Reciplease
//
//  Created by Maxime on 18/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import UIKit

class DetailsOfRecipeViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var quantitiesTableView: UITableView!
    @IBOutlet weak var infosView: UIView!
    
    //MARK: - Properties
    
    var recipeDetailsData: RecipeDetailsData?
    var favoriteRecipeData: Recipe?
    private var favoriteRecipesList = Recipe.fetchAll()
    var ingredients = [String]()
    var isFavorite = false
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quantitiesTableView.dataSource = self
        buttonSettings()
        displayRecipeInfos()
        title = "Reciplease"
        backBarButtonSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let id = favoriteRecipeData?.id else { return }
        if Recipe.isRegistered(id: id) {
            navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "favoriteButtonSelected")
        } else {
           navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "favoriteButton")
        }
    }
    
    //MARK: - Actions
    
    @IBAction func addToFavoriteButton(_ sender: Any) {
        switch isFavorite {
        case true:
            navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "favoriteButton")
            guard let id = favoriteRecipeData?.id else { return }
            Recipe.delete(id: id)
            navigationController?.popViewController(animated: true)
        case false:
            guard let id = recipeDetailsData?.id else { return }
            if Recipe.isRegistered(id: id) {
                navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "favoriteButton")
                Recipe.delete(id: id)
            } else {
                navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "favoriteButtonSelected")
                guard let recipeDetailsData = recipeDetailsData else { return }
                Recipe.create(recipeDetailsData: recipeDetailsData, ingredients: ingredients)
            }
        }
    }
    
    @IBAction func getDirectionsButtonTapped(_ sender: Any) {
        switch isFavorite {
        case true:
            guard let getDirectionsUrl = favoriteRecipeData?.url else { return }
            if let url = URL(string: getDirectionsUrl) {
                UIApplication.shared.open(url)
            }
        case false:
            guard let getDirectionsUrl = recipeDetailsData?.source.sourceRecipeUrl else { return }
            if let url = URL(string: getDirectionsUrl) {
                UIApplication.shared.open(url)
            }
        }
    
    }
    
    //MARK: - Class Methods
    
    private func backBarButtonSettings() {
        let backButton = UIBarButtonItem()
        backButton.tintColor = UIColor(white: 1.0, alpha: 1.0)
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func buttonSettings() {
        getDirectionsButton.layer.cornerRadius = 5
        getDirectionsButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        getDirectionsButton.layer.shadowColor = UIColor(white: 0.0, alpha: 1.0).cgColor
        getDirectionsButton.layer.shadowRadius = 5
        getDirectionsButton.layer.shadowOpacity = 0.3
        
        infosView.layer.borderWidth = 0.5
        infosView.layer.borderColor = UIColor(ciColor: .white).cgColor
        infosView.layer.cornerRadius = 3
    }
    
    // Display recipe infos
    private func displayRecipeInfos() {
        switch isFavorite {
        case true:
            recipeName.text = favoriteRecipeData?.name
            ratingLabel.text = favoriteRecipeData?.rating
            guard let time = favoriteRecipeData?.time else { return }
            preparationTimeLabel.text = time + "m"
            guard let image = favoriteRecipeData?.image else { return }
            recipeImageView.image = UIImage(data: image)
        case false:
            recipeName.text = recipeDetailsData?.name
            ratingLabel.text = recipeDetailsData?.rating.description
            calculateTimeInMinute()
            displayImage()
        }
        
    }
    
    // Convert time to minutes
    private func calculateTimeInMinute() {
        guard let timeInSecond = recipeDetailsData?.totalTimeInSeconds else { return }
        let result = timeInSecond/60
        preparationTimeLabel.text = result.description + "m"
    }
    
    // Display image
    private func displayImage() {
        if let imageStringUrl = recipeDetailsData?.images[0].hostedLargeUrl {
            guard let data = imageStringUrl.data else { return }
            recipeImageView.image = UIImage(data: data)
        } else {
            recipeImageView.image = #imageLiteral(resourceName: "defaultPicture")
        }
    }
    
}

//MARK: - TableView DataSource

extension DetailsOfRecipeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch isFavorite {
        case true:
            guard let ingredientLineEntities = favoriteRecipeData?.ingredientsLines?.allObjects as? [IngredientLine] else { return 0 }
            return ingredientLineEntities.count
        case false:
            guard let recipeIngredients = recipeDetailsData?.ingredientLines else { return 0 }
            return recipeIngredients.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsQuantitiesCell", for: indexPath)
        
        switch isFavorite {
        case true:
            guard let ingredientLineEntities = favoriteRecipeData?.ingredientsLines?.allObjects as? [IngredientLine] else { return UITableViewCell() }
            let ingredientsLines = ingredientLineEntities.map( { $0.name ?? ""})
            cell.textLabel?.text = "- " + ingredientsLines[indexPath.row]
            return cell
        case false:
            guard let recipeDetailsData = recipeDetailsData else { return UITableViewCell() }
            cell.textLabel?.text = "- " + recipeDetailsData.ingredientLines[indexPath.row]
            return cell
        }
    }
}
