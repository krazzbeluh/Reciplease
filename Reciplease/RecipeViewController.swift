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
    var recipe: Recipe!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func didTapRedirectionButton(_ sender: Any) {
        guard let url = URL(string: recipe.recipeUrl) else {
            showAlert(with: Errors.incorectUrl)
            return
        }
        UIApplication.shared.open(url)
    }
}

extension RecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Ingredients"
        } else {
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return recipe.ingredients.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IntroduceCell",
                                                           for: indexPath) as? IntroduceTableViewCell else {
                                                            return UITableViewCell()
            }
            cell.configure(title: recipe.name, image: recipe.imageUrl)
            
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell",
                                                           for: indexPath) as? IngredientTableViewCell else {
                                                            return UITableViewCell()
            }
            cell.configure(name: recipe.ingredients[indexPath.row].name)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
//
////
////  RecipeViewController.swift
////  Reciplease
////
////  Created by Paul Leclerc on 17/09/2019.
////  Copyright © 2019 Paul Leclerc. All rights reserved.
////
//
//import UIKit
//
//class RecipeViewController: UIViewController {
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var image: UIImageView!
//
//    var recipe: Recipe!
//
//    override func viewWillAppear(_ animated: Bool) {
//        titleLabel.text = recipe.name
//        tableView.reloadData()
//
//        let url = URL(string: recipe.imageUrl)
//        image.kf.setImage(with: url) { result in
//            switch result {
//            case .success(let imageResult):
//                print(imageResult)
//            case .failure(let error):
//                print(error)
//                self.image.image = #imageLiteral(resourceName: "DefaultImageCatalog")
//            }
//        }
//    }
//
//    @IBAction func didTapRedirectionButton(_ sender: Any) {
//        guard let url = URL(string: recipe.recipeUrl) else {
//            showAlert(with: Errors.incorectUrl)
//            return
//        }
//        UIApplication.shared.open(url)
//    }
//}
//
//extension RecipeViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return recipe.ingredients.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell",
//                                                       for: indexPath) as? IngredientTableViewCell else {
//                                                        return UITableViewCell()
//        }
//
//        cell.configure(name: recipe.ingredients[indexPath.row].name)
//
//        return cell
//    }
//}
