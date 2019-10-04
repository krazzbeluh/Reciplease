//
//  BookmarkFetcher.swift
//  Reciplease
//
//  Created by Paul Leclerc on 23/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation

class BookmarkFetcher {
    
    init(identifier: String) {
        self.identifier = identifier
        networkService = NetworkService(url: url)
    }
    
    var networkService = NetworkService(url: "https://www.google.fr")
    private var url: String {
        let returnUrl = "https://api.edamam.com/search?app_id=API signup&app_key=" + key + "&q=" + identifier //swiftlint:disable:this line_length
        return returnUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    private let key = "fed2ff4a"
    var identifier: String
    
//    Main func
    func fetchRecipe(completion: @escaping (Result<Recipe?, Error>) -> Void) {
        networkService.getData { result in
            switch result {
            case .success(let data):
                guard let recipesData = try? JSONDecoder().decode(Edamam.self, from: data) else {
                    completion(.failure(DecoderError.unableToDecodeData))
                    return
                }
                
                var recipe: Recipe?
                for hit in recipesData.hits {
                    
                    var ingredients = [Ingredient]()
                    for ingredient in hit.recipe.ingredients {
                        ingredients.append(Ingredient(name: ingredient.food))
                    }
                    
                    recipe = Recipe(name: hit.recipe.label,
                                          image: hit.recipe.image,
                                          recipe: hit.recipe.url,
                                          ingredients: ingredients,
                                          uri: hit.recipe.uri)
                }
                
                completion(.success(recipe))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
