//
//  Recipe.swift
//  Reciplease
//
//  Created by Paul Leclerc on 18/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation

class Recipe {
    var name: String
    var imageUrl: String
    var recipeUrl: String
    var ingredients: [Ingredient]
    var uri: String
    
    private struct Keys {
        static let bookmarks = "bookmarks"
    }
    
    init(name: String, image: String, recipe: String, ingredients: [Ingredient], uri: String) {
        self.name = name
        imageUrl = image
        recipeUrl = recipe
        self.ingredients = ingredients
        self.uri = uri
    }
    
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.uri == rhs.uri
    }
}
