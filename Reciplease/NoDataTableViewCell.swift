//
//  NoDataTableViewCell.swift
//  Reciplease
//
//  Created by Paul Leclerc on 09/10/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

class NoDataTableViewCell: UITableViewCell {

    @IBOutlet weak var warningText: UILabel!
    
    func configure(fromPreSearch: Bool) {
        if fromPreSearch {
            warningText.text = "No recipes found !"
        } else {
            warningText.text = "You have no bookmarks !"
        }
    }

}
