//
//  DetailRecipeViewController.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import UIKit
import Kingfisher

final class DetailRecipeViewController: UIViewController {
    
    // MARK: - CollectionView Section Enum
    
    enum Section {
        case title
        case chefName
        case tags
        case description
    }
  
    init(viewModel: DetailRecipeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Not supported!")
    }
    
    // MARK: - ViewModel
    
    private var viewModel: DetailRecipeViewModel!
  
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    override func loadView() {
        super.loadView()
        self.view = self.viewModel?.detailRecipeView
    }
    
   
}
