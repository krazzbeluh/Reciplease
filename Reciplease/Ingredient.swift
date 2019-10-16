//
//  Ingredient.swift
//  Reciplease
//
//  Created by Paul Leclerc on 18/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation

class Ingredient {
    enum IngredientListError: Error { // errors about ingredients list
        case ingredientAlreadyInList, voidList
    }
    
    static var listForSearch: [String] = [] // the ingredients names list typed by user in preSearchVC
    
    let name: String // ingredient name
    
    init(name: String) { // inits an ingredient
        self.name = name
    }
    
    func asBIngredient() -> BIngredient { // converts self to BIngredient
        let bIngredient = BIngredient(context: AppDelegate.viewContext)
        bIngredient.name = self.name
        return bIngredient
    }
}
