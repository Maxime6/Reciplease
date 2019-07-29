//
//  CustomRecipeTableViewCell.swift
//  Reciplease
//
//  Created by Maxime on 24/06/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import UIKit

class CustomRecipeTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var infosView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var recipeTimeLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var recipeTimeImageView: UIImageView!
    
    //MARK: - Properties
    
    var yummlyService: YummlyService?
    
    // To display recipe infos
    var recipe: Match? {
        didSet {
            recipeNameLabel.text = recipe?.recipeName
            recipeIngredientsLabel.text = recipe?.ingredients.joined(separator: ", ")
            ratingLabel.text = recipe?.rating.description
            calculateTimeInMinute()
            if let imageStringUrl = recipe?.smallImageUrls?[0].updateSizeOfUrlImage {
                guard let data = imageStringUrl.data else { return }
                self.recipeImageView.image = UIImage(data: data)
            } else {
                self.recipeImageView.image = #imageLiteral(resourceName: "defaultPicture")
            }
            
        }
    }
    
    // To display favorite recipe infos
    var favoriteRecipe: Recipe? {
        didSet {
            recipeNameLabel.text = favoriteRecipe?.name
            ratingLabel.text = favoriteRecipe?.rating?.description
            guard let time = favoriteRecipe?.time else { return }
            recipeTimeLabel.text = time.description + "m"
            let ingredientEntities = favoriteRecipe?.ingredients?.allObjects as? [Ingredient]
            let ingredients = ingredientEntities?.map({ $0.name ?? "" }).joined(separator: ", ") ?? ""
            recipeIngredientsLabel.text = ingredients
            guard let data = favoriteRecipe?.image else { return }
            recipeImageView.image = UIImage(data: data)
            // image par defaut
        }
    }
    
    //MARK: - Class Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellSettings()
    }
    
    func cellSettings() {
        recipeView.layer.cornerRadius = 3
        recipeView.layer.shadowRadius = 6
        recipeView.layer.shadowColor = UIColor(ciColor: .black).cgColor
        recipeView.layer.shadowOpacity = 0.4
        recipeView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        infosView.layer.borderWidth = 0.5
        infosView.layer.borderColor = UIColor(ciColor: .white).cgColor
        infosView.layer.cornerRadius = 3
    }
    
    func calculateTimeInMinute() {
        guard let timeInSecond = recipe?.totalTimeInSeconds else { return }
        let result = timeInSecond / 60
        recipeTimeLabel.text = result.description + "m"
    }
    
}
