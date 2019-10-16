//
//  IngredientTableViewCell.swift
//  Reciplease
//
//  Created by Paul Leclerc on 17/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel! // ingredient name
    
    func configure(name: String) { // configures cell
        nameLabel.text = name
    }

}
