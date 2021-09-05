//
//  ListRecipesViewController.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import Foundation
import UIKit

class ListRecipesViewController: UIViewController {
    
    init(viewModel: ListRecipesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Not supported!")
    }

    private var viewModel: ListRecipesViewModel?
    
    override func loadView() {
        super.loadView()
        self.viewModel?.setupView()
        self.view = self.viewModel?.listRecipeView
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("welcome to recipes list")
        receipesLoadAction()
        viewModel?.viewDidLoad()
    }
    
    private func receipesLoadAction(){
        viewModel?.loadSuccess = { [weak self] in
            self?.viewModel?.listRecipeView?.hideLoading()
            print(self?.viewModel?.recipeItemModel(at: IndexPath(row: 0, section: 0)).title)
        }
        
        viewModel?.loadFailed = { [weak self] (message) in
            self?.viewModel?.listRecipeView?.hideLoading()
            print(message)
        }
    }
   
}
