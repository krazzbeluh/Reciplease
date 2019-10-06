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
    
    private struct Keys {
        static let bookmarks = "bookmarks"
    }
    static var bookmarks: [String] {
        get {
            return UserDefaults.standard.object(forKey: Keys.bookmarks) as? [String] ?? [String]()
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.bookmarks)
        }
    }
    
    init(name: String, image: String, recipe: String, ingredients: [Ingredient], uri: String) {
        self.name = name
        imageUrl = image
        recipeUrl = recipe
        self.ingredients = ingredients
        
        let unUsedUriSize = 51
        let index = uri.count - unUsedUriSize
        let identifier = String(uri.suffix(index))
        print(identifier)
        
        self.identifier = identifier
    }
    
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
