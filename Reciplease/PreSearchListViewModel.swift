//
//  PreSearchListViewModel.swift
//  Reciplease
//
//  Created by Paul Leclerc on 23/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation

class PreSearchViewModel {
    static var delegate: PreSearchDelegate!
    static func addIngredient(_ ingredient: String?) {
        guard let ingredient = ingredient else {
            delegate?.showAlert(with: Errors.nilInTextField)
            return
        }
        
        guard ingredient != "" else {
            delegate?.showAlert(with: Errors.nilInTextField)
            return
        }
        
        for ingredientInList in IngredientListForSearch.ingredients {
            guard ingredient != ingredientInList else {
                delegate?.showAlert(with: Errors.ingredientAlreadyInList)
                return
            }
        }
        
        IngredientListForSearch.addIngredient(ingredient)
        
        delegate?.clearTextField()
    }
}
