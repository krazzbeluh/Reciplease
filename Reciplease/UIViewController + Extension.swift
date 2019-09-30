//
//  UIViewController + Extension.swift
//  Reciplease
//
//  Created by Paul Leclerc on 21/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation
import UIKit

protocol DisplayAlert: UIViewController {
    func showAlert(with type: Error)
}

extension UIViewController: DisplayAlert {
    enum UIError: Error {
        case nilInTextField
    }
    
    func showAlert(with error: Error) {
        let message: String
        switch error {
        case UIError.nilInTextField:
            message = "Please type something"
        case IngredientListForSearch.IngredientListError.ingredientAlreadyInList:
            message = "This ingredient is already in list"
        case IngredientListForSearch.IngredientListError.voidList:
            message = "Please insert ingredient"
        case NetworkService.NetworkError.incorectUrl:
            message = "Invalid URL"
        case NetworkService.NetworkError.noData:
            message = "Unable to fetch data"
        case NetworkService.NetworkError.responseNot200:
            message = "API response error"
        case DecoderError.unableToDecodeData:
            message = "Unable to decode data"
        default:
            message = "Erreur : \(error)"
        }
        sendAlert(message: message)
    }
    
    private func sendAlert(message: String) {
        let alertVC = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
