//
//  ListRecipesViewController.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

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
        
        setupUI()
        receipesLoadAction()
        viewModel?.viewDidLoad()
    }
    
    private func receipesLoadAction(){
        viewModel?.loadSuccess = { [weak self] in
            self?.viewModel?.listRecipeView?.hideLoading()
            self?.viewModel?.reloadTableView()
        }
        
        viewModel?.loadFailed = { [weak self] (message) in
            self?.viewModel?.listRecipeView?.hideLoading()
            self?.showAlert("Error", message: message)
        }
    }
    
    private func setupUI() {
        title = "Recipes List"
        self.viewModel?.listRecipeView?.tableView.delegate = self
        self.viewModel?.listRecipeView?.tableView.dataSource = self
        self.viewModel?.listRecipeView?.tableView.rowHeight = 300
        self.viewModel?.listRecipeView?.tableView.tableFooterView = UIView()
    }
   
}

// MARK: - TableView Delegate and DataSource

extension ListRecipesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListRecipeTableViewCell.reuseIdentifier, for: indexPath) as? ListRecipeTableViewCell {
            cell.updateCell(with: viewModel?.recipeItemModel(at: indexPath))
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }
        navigationController?.pushViewController(viewModel.gotoRecipeDetail(for: indexPath), animated: true)
        
    }
}
