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
    let identifier: String
    
    init(name: String, image: String, recipe: String, ingredients: [Ingredient], uri: String) {
        self.name = name
        imageUrl = image
        recipeUrl = recipe
        self.ingredients = ingredients
        
        let unUsedUriSize = 51
        let index = uri.count - unUsedUriSize
        let mySubstring = String(uri.suffix(index))
        print(mySubstring)
        
        identifier = uri
    }
    
}
