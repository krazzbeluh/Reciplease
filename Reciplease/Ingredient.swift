//
//  Ingredient.swift
//  Reciplease
//
//  Created by Paul Leclerc on 18/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation

class Ingredient {
    enum IngredientListError: Error {
        case ingredientAlreadyInList, voidList
    }
    
    static var listForSearch: [String] = []
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
