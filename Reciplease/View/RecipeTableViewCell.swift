//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Maxime on 12/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var infosView: UIView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(recipeImage: UIImage, recipeTitle: String, recipeIngredients: String, likes: String, time: String) {
        // ajout d'une image sur recipeView
        recipeTitleLabel.text = recipeTitle
        recipeIngredientsLabel.text = recipeIngredients
        likesLabel.text = likes
        preparationTimeLabel.text = time
    }

}
