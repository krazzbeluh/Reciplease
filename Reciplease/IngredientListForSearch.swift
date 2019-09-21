//
//  IngredientListForSearch.swift
//  Reciplease
//
//  Created by Paul Leclerc on 18/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation

class IngredientListForSearch {
    private init() {}
    static var ingredients: [String] = []
    
    static func addIngredient(_ ingredient: String) {
        ingredients.append(ingredient)
    }
}
