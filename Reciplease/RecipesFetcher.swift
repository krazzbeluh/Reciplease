//
//  RecipesFetcher.swift
//  Reciplease
//
//  Created by Paul Leclerc on 23/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation
import Alamofire

class RecipesFetcher {
    private var url: String {
        var ingredientsString = ""
        
        var firstLoopTurn = true
        for i in ingredients {
            if !firstLoopTurn {
                ingredientsString += ", "
            }
            ingredientsString += i
            firstLoopTurn = false
        }
        
        let returnUrl = "https://api.edamam.com/search?app_id=API signup&app_key=" + key + "&q=" + ingredientsString
        return returnUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    private let key = "fed2ff4a"
    private var ingredients: [String] {
        return IngredientListForSearch.ingredients
    }
    
//    Main func
    func fetchRecipes(completion: @escaping (Result<[Recipe], Errors>) -> Void) {
        guard let url = URL(string: self.url) else {
            completion(.failure(.incorectUrl))
          return
        }
        
        AF.request(url).response { response in
            debugPrint(response)
        }
    }
}
