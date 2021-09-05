//
//  ListReceipes.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import Foundation
import UIKit

class ListRecipesViewModel {
    var listRecipeView: ListRecipeView?
    
    func setupView() {
        listRecipeView = ListRecipeView(frame: UIScreen.main.bounds)
    }
}

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
    }
   
}

class ListRecipeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
