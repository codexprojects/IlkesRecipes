//
//  ListReceipes.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import Foundation

protocol ListRecipes {
    
    func setupView()
    func viewDidLoad()
    func loadRecipes()
    func numberOfItems() -> Int
    func recipeItemModel(at indexPath: IndexPath) -> RecipeCellModel
    func reloadTableView()
    func gotoRecipeDetail(for indexPath: IndexPath) -> DetailRecipeViewController
}

