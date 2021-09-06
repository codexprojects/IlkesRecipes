//
//  ListRecipeView.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import UIKit

class ListRecipeView: UIView {
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView = UITableView(frame: self.bounds)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .systemBackground
        tableView.register(ListRecipeTableViewCell.self, forCellReuseIdentifier: ListRecipeTableViewCell.reuseIdentifier)
        return tableView
    }()
   
    var spinner = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
     
        addSubview(tableView)
        addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        tableView.contentInsetAdjustmentBehavior = .automatic
        
        showLoading()
    }
    
    func showLoading() {
        spinner.startAnimating()
    }
    
    func hideLoading() {
        spinner.stopAnimating()
    }
}
