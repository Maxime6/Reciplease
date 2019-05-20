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
    @IBOutlet weak var recipeImageView: UIImageView!
    
    var yummlyService: YummlyService?
    
    var recipe: Match? {
        didSet {
//            networkCall()
            displayImage()
            recipeTitleLabel.text = recipe?.recipeName
            recipeIngredientsLabel.text = recipe?.ingredients.joined(separator: ", ")
            likesLabel.text = recipe?.rating.description
//            preparationTimeLabel.text = recipe?.totalTimeInSeconds.description
            calculateTimeInMinute()
        }
    }
    

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
    
    func displayImage() {
        guard let imageStringUrl = recipe?.smallImageUrls?[0].updateSizeOfUrlImage else { return }
        print(imageStringUrl)
        guard let imageUrl = URL(string: imageStringUrl) else { return }
        if let imageData: NSData = NSData(contentsOf: imageUrl) {
            recipeImageView.image = UIImage(data: imageData as Data)
        }
    }
    
    func networkCall() {
        yummlyService?.getImagesData(completionHandler: { (data) in
            if let imageData = data {
                self.recipeImageView.image = UIImage(data: imageData)
            }
        })
    }
    
    func calculateTimeInMinute() {
        guard let timeInSecond = recipe?.totalTimeInSeconds else { return }
        let result = timeInSecond / 60
        preparationTimeLabel.text = result.description + "m"
    }

}
