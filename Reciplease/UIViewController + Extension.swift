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
    func showAlert(with type: Errors)
}

extension UIViewController: DisplayAlert {
    func showAlert(with type: Errors) {
        let message: String
        switch type {
        case .nilInTextField:
            message = "Please type something"
        case .ingredientAlreadyInList:
            message = "This ingredient is already in list"
        case .networkError:
            message = "Invalid network connexion"
        case .incorectUrl:
            message = "Invalid URL"
        case .noData:
            message = "Unable to fetch data"
        case .responseNot200:
            message = "API response error"
        case .unableToDecodeData:
            message = "Unable to decode data"
        }
        sendAlert(message: message)
    }
    
    private func sendAlert(message: String) {
        let alertVC = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
