//
//  RecipleaseErrors.swift
//  Reciplease
//
//  Created by Paul Leclerc on 21/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import Foundation

enum Errors: Error {
    case nilInTextField, ingredientAlreadyInList
//    Networking Errors
    case noData, responseNot200, incorectUrl
//    Data errors
    case unableToDecodeData
}
