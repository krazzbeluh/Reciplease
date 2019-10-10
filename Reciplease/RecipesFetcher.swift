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
    enum FetcherError: Error {
        case noData
    }
    
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
    
// MARK: Main func
    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        AF.request(url).responseJSON { response in
            self.treatment(response: response) { response in
                completion(response)
            }
        }
    }
    
    func treatment(response: AFDataResponse<Any>, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        switch response.result {
        case .success(_):
            guard let data = response.data else {
                completion(.failure(FetcherError.noData))
                return
            }
            
            switch EdamamDecode.convertToRecipes(data: data) {
            case .success(let recipes):
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        case .failure(let error):
            print(error)
        }
    }
}
