//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Paul Leclerc on 17/09/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var recipe: Recipe!
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = recipe.name
        tableView.reloadData()
        
        if let imageData = recipe.image {
            image.image = UIImage(data: imageData)
        } else {
            image.image = #imageLiteral(resourceName: "DefaultImageCatalog")
        }
    }

}

extension RecipeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell",
                                                       for: indexPath) as? IngredientTableViewCell else {
                                                        return UITableViewCell()
        }
        
        cell.configure(name: recipe.ingredients[indexPath.row].name)
        
        return cell
    }
}
