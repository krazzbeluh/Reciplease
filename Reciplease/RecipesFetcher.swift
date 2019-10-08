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
        
        let returnUrl = "https://api.edamam.com/search?app_id=API signup&app_key=" + key + "&q=" + ingredientsString + "&from=0&to=20" //swiftlint:disable:this line_length
        return returnUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    private let key = "fed2ff4a"
    private var ingredients: [String] {
        return Ingredient.listForSearch
    }
    
//    Main func
    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        AF.request(url).responseJSON { response in
            debugPrint("\n\napi response >>>\(String(describing: response.value))\n")
            
            switch response.result {
            case .success(_):
                guard let data = response.data else {
                    return
                }
                
                guard let recipesDecoded = try? JSONDecoder().decode(Edamam.self, from: data) else {
                    return
                }
                
                var recipes = [Recipe]()
                for hit in recipesDecoded.hits {
                    
                    var ingredients = [Ingredient]()
                    for ingredient in hit.recipe.ingredients {
                        ingredients.append(Ingredient(name: ingredient.food))
                    }
                    
                    recipes.append(Recipe(name: hit.recipe.label,
                                          image: hit.recipe.image,
                                          recipe: hit.recipe.url,
                                          ingredients: ingredients,
                                          uri: hit.recipe.uri))
                }
                
                completion(.success(recipes))
            case .failure(let error):
                print(error)
            }
        }
    }
}
