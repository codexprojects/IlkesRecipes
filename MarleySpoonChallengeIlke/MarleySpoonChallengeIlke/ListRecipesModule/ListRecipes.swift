//
//  ListReceipes.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import Foundation
import UIKit

class ListRecipesViewModel: ObservableObject {
    
    private let remoteRecipeLoader: RemoteRecipeLoaderAPIProtocol
    private var recipes: [Recipe] = []
    var onFetchCompleted: ()->() = {}
    var onFetchFailed: (String)->() = { _ in }
    
    var listRecipeView: ListRecipeView?
    
    init(remoteRecipeLoader: RemoteRecipeLoaderAPIProtocol = RemoteRecipeLoaderAPI()) {
        self.remoteRecipeLoader = remoteRecipeLoader
    }
    
    func viewDidLoad(){
        fetchRecipes()
    }
    
    func setupView() {
        listRecipeView = ListRecipeView(frame: UIScreen.main.bounds)
    }
    
    private func fetchRecipes(){
        remoteRecipeLoader.fetchAllRecipes { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let recipes):
                    self?.recipes = recipes
                    print(recipes.count)
                    self?.onFetchCompleted()
                case .failure(let error):
                    self?.onFetchFailed("Somthing went wrong: \(error.localizedDescription)")
                }
            }
        }
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
        setupCallBacks()
        viewModel?.viewDidLoad()
    }
    
    private func setupCallBacks(){
        viewModel?.onFetchCompleted = { [weak self] in
            print("fetched")
            self?.viewModel?.listRecipeView?.hideLoading()
        
        }
        
        viewModel?.onFetchFailed = { [weak self] (message) in
            self?.viewModel?.listRecipeView?.hideLoading()
            print(message)
        }
    }
   
}

class ListRecipeView: UIView {
    var spinner = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.backgroundColor = .systemPink
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        showLoading()
    }
    
    func showLoading() {
        spinner.startAnimating()
    }
    
    func hideLoading() {
        spinner.stopAnimating()
    }
}
