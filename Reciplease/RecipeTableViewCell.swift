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
    @IBOutlet weak var mark: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dishButton.contentHorizontalAlignment = .fill
        dishButton.contentVerticalAlignment = .fill
        dishButton.imageView?.contentMode = .scaleAspectFill
    }
    
    func configure(recipeId: Int, recipe: Recipe) {
        nameLabel.text = recipe.name
        
        dishButton.titleLabel?.text = String(recipeId)
        self.mark.text = String(recipe.mark)
        
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
        dishButton.kf.setImage(with: url, for: .normal) { result in
            switch result {
            case .success(let imageResult):
                print(imageResult)
            case .failure(let error):
                print(error)
                self.dishButton.setImage(#imageLiteral(resourceName: "DefaultImageCatalog"), for: .normal)
            }
        }
    }
}
