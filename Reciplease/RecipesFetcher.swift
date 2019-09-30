//
//  RecipesFetcher.swift
//  Reciplease
//
//  Created by Paul Leclerc on 23/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation
//import Alamofire

class RecipesFetcher {
    init() {}
    required init(session: NetworkSession) {
        networkSession = session
    }
    
    private var networkSession = NetworkSession()
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
        return IngredientListForSearch.ingredients
    }
    
//    Main func
    func fetchRecipes(completion: @escaping (Result<[Recipe], Errors>) -> Void) {
        networkSession.request(url: url) { result in
            switch result {
            case .success(let data):
                guard let recipesData = try? JSONDecoder().decode(Welcome.self, from: data) else {
                    completion(.failure(.unableToDecodeData))
                    return
                }
                
                var recipes = [Recipe]()
                for hit in recipesData.hits {
                    
                    var ingredients = [Ingredient]()
                    for ingredient in hit.recipe.ingredients {
                        ingredients.append(Ingredient(name: ingredient.food,
                                                      quantity: ingredient.quantity,
                                                      measure: ingredient.measure ?? ""))
                    }
                    
                    recipes.append(Recipe(name: hit.recipe.label,
                                          image: hit.recipe.image,
                                          recipe: hit.recipe.url,
                                          ingredients: ingredients,
                                          mark: hit.recipe.yield))
                }
                
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
