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
    func showAlert(with type: Error) {
        let message: String
        switch type {
        case Errors.nilInTextField:
            message = "Please type something"
        case Errors.ingredientAlreadyInList:
            message = "This ingredient is already in list"
        default:
            message = "Erreur: Inconnue (\(type))"
        }
        sendAlert(message: message)
    }
    
    private func sendAlert(message: String) {
        let alertVC = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
