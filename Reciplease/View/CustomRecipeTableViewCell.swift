//
//  CustomRecipeTableViewCell.swift
//  Reciplease
//
//  Created by Maxime on 24/06/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import UIKit

class CustomRecipeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var infosView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var recipeTimeLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var recipeTimeImageView: UIImageView!
    
    
    var yummlyService: YummlyService?
    var downloadDataService: DownloadDataService?
    
    var recipe: Match? {
        didSet {
            //            displayImage()
            recipeNameLabel.text = recipe?.recipeName
            recipeIngredientsLabel.text = recipe?.ingredients.joined(separator: ", ")
            ratingLabel.text = recipe?.rating.description
            //            preparationTimeLabel.text = recipe?.totalTimeInSeconds.description
            calculateTimeInMinute()
            if let imageStringUrl = recipe?.smallImageUrls?[0].updateSizeOfUrlImage {
                DownloadDataService.getData(with: imageStringUrl) { (data) in
                    guard let data = data else { return }
                    self.recipeImageView.image = UIImage(data: data)
                }
            } else {
                // config image par defaut
            }
            
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
    
    func calculateTimeInMinute() {
        guard let timeInSecond = recipe?.totalTimeInSeconds else { return }
        let result = timeInSecond / 60
        recipeTimeLabel.text = result.description + "m"
    }
    
}
