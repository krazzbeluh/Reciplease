//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Paul Leclerc on 17/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientsList: UILabel!
    @IBOutlet weak var dishButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dishButton.contentHorizontalAlignment = .fill
        dishButton.contentVerticalAlignment = .fill
        dishButton.imageView?.contentMode = .scaleAspectFill
    }
    
    func configure(recipeId: Int, recipe: Recipe) {
        nameLabel.text = recipe.name
        
        dishButton.titleLabel?.text = String(recipeId)
        
        var ingredientsList = ""
        var index = 0
        for ingredient in recipe.ingredients {
            if index != 0 {
                ingredientsList += ", "
            }
            ingredientsList += ingredient.name
            index += 1
        }
        
        self.ingredientsList.text = ingredientsList

        let url = URL(string: recipe.imageUrl)
        dishButton.kf.setImage(with: url, for: .normal, placeholder: #imageLiteral(resourceName: "DefaultImageCatalog")) { result in
            switch result {
            case .success(let imageResult):
                print(imageResult)
            case .failure(let error):
                print(error)
            }
        }
    }
}
