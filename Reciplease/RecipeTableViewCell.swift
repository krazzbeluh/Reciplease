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
    @IBOutlet weak var dishButton: UIButton!
    @IBOutlet weak var mark: UILabel!
    @IBOutlet weak var cookingTime: UILabel!
    
    func configure(recipeId: Int, recipe: Recipe) {
        nameLabel.text = recipe.name
        dishButton.setImage(#imageLiteral(resourceName: "DefaultImageCatalog"), for: .normal)
        dishButton.titleLabel?.text = String(recipeId)
        self.mark.text = String(recipe.mark)
        self.cookingTime.text = String(recipe.cookingTime) + "m "
        
        var ingredientsList = ""
        for ingredient in recipe.ingredients {
            ingredientsList += ingredient.name + ", "
        }
        
        self.ingredientsList.text = ingredientsList
    }

}
