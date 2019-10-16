//
//  UIViewController + Extension.swift
//  Reciplease
//
//  Created by Paul Leclerc on 21/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation
import UIKit

protocol DisplayAlert: UIViewController { // protocol to add method to every UIViewController
    func showAlert(with type: Error)
}

extension UIViewController: DisplayAlert {
    enum UIError: Error { // UIErrors
        case nilInTextField
    }
    
    func showAlert(with error: Error) { // configures alert
        let message: String
        switch error {
        case UIError.nilInTextField:
            message = "Please type something"
        case Ingredient.IngredientListError.ingredientAlreadyInList:
            message = "This ingredient is already in list"
        case Ingredient.IngredientListError.voidList:
            message = "Please insert ingredient"
        case RecipesFetcher.FetcherError.incorectUrl:
            message = "Invalid URL"
        case RecipesFetcher.FetcherError.noData:
            message = "Unable to fetch data"
        case EdamamDecode.DecoderError.unableToDecodeData:
            message = "Unable to decode data"
        default:
            message = "Erreur : \(error)"
        }
        sendAlert(message: message)
    }
    
    private func sendAlert(message: String) { // sends alert
        let alertVC = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
