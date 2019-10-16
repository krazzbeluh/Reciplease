//
//  Recipe.swift
//  Reciplease
//
//  Created by Paul Leclerc on 18/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation

class Recipe {
    var name: String // the recipe name
    var imageUrl: String // the image url
    var recipeUrl: String // the complete recipe url
    var ingredients: [Ingredient] // the ingredients
    var uri: String // the identifier
    
    private struct Keys {
        static let bookmarks = "bookmarks" // avoids keyboard typos
    }
    
//    inits the object
    init(name: String, image: String, recipe: String, ingredients: [Ingredient], uri: String) {
        self.name = name
        imageUrl = image
        recipeUrl = recipe
        self.ingredients = ingredients
        self.uri = uri
    }
    
}

// used to compare 2 recipes
extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.uri == rhs.uri
    }
}
