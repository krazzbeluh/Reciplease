//
//  Recipe.swift
//  Reciplease
//
//  Created by Paul Leclerc on 18/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation

class Recipe {
    let name: String
    let imageUrl: String
    let recipeUrl: String
    let ingredients: [Ingredient]
    let mark: Float
    
    init(name: String, image: String, recipe: String, ingredients: [Ingredient], mark: Float) {
        self.name = name
        imageUrl = image
        recipeUrl = recipe
        self.ingredients = ingredients
        self.mark = mark
    }
    
}
