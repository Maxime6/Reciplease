//
//  DetailsOfRecipeViewController.swift
//  Reciplease
//
//  Created by Maxime on 18/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import UIKit

class DetailsOfRecipeViewController: UIViewController {
    
    var recipeData: RecipesData?
    var recipeDetailsData: RecipeDetailsData?
    var favoriteRecipesList = Recipe.fetchAll()

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var quantitiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quantitiesTableView.dataSource = self
        buttonSettings()
        displayRecipeInfos()
        navigationItem.title = "Reciplease"
        displayImage()
        backBarButtonSettings()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "favoriteButton"), style: .plain, target: self, action: #selector(addToFavorites))

    }
    
    @IBAction func getDirectionsButtonTapped(_ sender: Any) {
        guard let getDirectionsUrl = recipeDetailsData?.source.sourceRecipeUrl else { return }
        if let url = URL(string: getDirectionsUrl) {
            UIApplication.shared.open(url)
        }
    }
    
    func backBarButtonSettings() {
        let backButton = UIBarButtonItem()
        backButton.tintColor = UIColor(ciColor: .white)
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func buttonSettings() {
        getDirectionsButton.layer.cornerRadius = 5
        getDirectionsButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        getDirectionsButton.layer.shadowColor = UIColor(ciColor: .black).cgColor
        getDirectionsButton.layer.shadowRadius = 5
        getDirectionsButton.layer.shadowOpacity = 0.3
    }
    
    func displayRecipeInfos() {
        recipeName.text = recipeDetailsData?.name
        ratingLabel.text = recipeDetailsData?.rating.description
        calculateTimeInMinute()
    }
    
    func calculateTimeInMinute() {
        guard let timeInSecond = recipeDetailsData?.totalTimeInSeconds else { return }
        let result = timeInSecond/60
        preparationTimeLabel.text = result.description + "m"
    }
    
    func displayImage() {
        guard let imageStringUrl = recipeDetailsData?.images[0].hostedLargeUrl else { return }
        guard let imageUrl = URL(string: imageStringUrl) else { return }
        if let imageData: NSData = NSData(contentsOf: imageUrl) {
            recipeImageView.image = UIImage(data: imageData as Data)
        }
    }
    
    @objc func addToFavorites(indexPath: IndexPath) {
        let favoriteRecipe = Recipe(context: AppDelegate.viewContext)
//        favoriteRecipe.name = recipeData?.matches[indexPath.row].recipeName
        favoriteRecipe.name = recipeDetailsData?.name
        favoriteRecipe.rating = recipeData?.matches[indexPath.row].rating.description
        favoriteRecipe.time = recipeData?.matches[indexPath.row].totalTimeInSeconds.description
        try? AppDelegate.viewContext.save()
    }
    
}

extension DetailsOfRecipeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipeIngredients = recipeDetailsData?.ingredientLines else { return 0 }
        return recipeIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsQuantitiesCell", for: indexPath)
        guard let recipeDetailsData = recipeDetailsData else { return UITableViewCell() }
        cell.textLabel?.text = "- " + recipeDetailsData.ingredientLines[indexPath.row]
        return cell
    }
}
