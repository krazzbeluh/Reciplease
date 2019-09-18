//
//  Ingredient.swift
//  Reciplease
//
//  Created by Paul Leclerc on 18/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation

class Ingredient {
    
    let name: String
    let quantity: Float
    let measure: String
    
    init(name: String, quantity: Float, measure: String) {
        self.name = name
        self.quantity = quantity
        self.measure = measure
    }
}
