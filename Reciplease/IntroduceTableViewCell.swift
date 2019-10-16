//
//  IntroduceTableViewCell.swift
//  Reciplease
//
//  Created by Paul Leclerc on 30/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit
import Kingfisher

class IntroduceTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel! // recipe name
    @IBOutlet weak var recipeImage: UIImageView! // recipe image
    
    func configure(title: String, image: String) { // configures cell
        self.title.text = title
        recipeImage.kf.setImage(with: URL(string: image)) { result in
            switch result {
            case .success(let imageResult):
                print(imageResult)
            case .failure(let error):
                print(error)
                self.recipeImage.image = #imageLiteral(resourceName: "DefaultImageCatalog")
            }
        }
    }

}
