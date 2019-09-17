//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Paul Leclerc on 17/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientsList: UILabel!
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var mark: UILabel!
    @IBOutlet weak var cookingTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(name: String, ingredients: [String], image: UIImage, mark: Float, cookingTime: Int) {
        nameLabel.text = name
        dishImage.image = image
        self.mark.text = String(mark)
        self.cookingTime.text = String(cookingTime) + "m "
        
        var ingredientsList = ""
        for ingredient in ingredients {
            ingredientsList += ingredient + " "
        }
        
        self.ingredientsList.text = ingredientsList
    }

}
