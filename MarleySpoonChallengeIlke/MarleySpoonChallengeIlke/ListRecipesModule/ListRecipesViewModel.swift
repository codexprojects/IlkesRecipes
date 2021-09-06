//
//  ListRecipesViewModel.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import Foundation
import UIKit

class ListRecipesViewModel: ListRecipes {
    
    private let remoteRecipeLoader: RecipeLoader
    private var recipesList: [Recipe] = []
    
    var loadSuccess: () -> () = {}
    var loadFailed: (String) -> () = { _ in }
   
    var listRecipeView: ListRecipeView?
    
    init(remoteRecipeLoader: RecipeLoader = RemoteRecipeLoader(queryString: ContentTypeQuery.recipe.rawValue)) {
        self.remoteRecipeLoader = remoteRecipeLoader
    }
    
    func viewDidLoad() {
        loadRecipes()
    }
    
    internal func loadRecipes() {
        remoteRecipeLoader.loadAllRecipes() { [weak self] result in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result{
                case .success(let recipes):
                    self.recipesList = recipes
                    self.loadSuccess()
                case .failure(let error):
                    self.loadFailed("Failed to load with error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func setupView() {
        listRecipeView = ListRecipeView(frame: UIScreen.main.bounds)
    }
    
    func numberOfItems() -> Int {
        return recipesList.count
    }
    
    func recipeItemModel(at indexPath: IndexPath) -> RecipeCellModel {
        return RecipeCellModel(recipe: recipesList[indexPath.item])
    }
    
    func reloadTableView() {
        listRecipeView?.tableView.reloadData()
    }
    
    func gotoRecipeDetail(for indexPath: IndexPath) -> DetailRecipeViewController {
        
        let viewModel = DetailRecipeViewModel(recipe: recipesList[indexPath.item])
        return DetailRecipeViewController.init(viewModel: viewModel)
    }
}
