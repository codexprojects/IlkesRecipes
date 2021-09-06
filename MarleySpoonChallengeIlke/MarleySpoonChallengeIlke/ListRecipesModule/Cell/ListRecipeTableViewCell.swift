//
//  ListRecipeTableViewCell.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import UIKit
import Kingfisher

class ListRecipeTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: ListRecipeTableViewCell.self)
    
    // MARK: - UI Elements
    
    lazy var recipeImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.sizeToFit()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    lazy var recipeTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .systemIndigo
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        contentView.backgroundColor = .systemBackground
        
        recipeTitle.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(recipeImageView)
        contentView.addSubview(recipeTitle)
        
        let inset = CGFloat(10)
        
        NSLayoutConstraint.activate([
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            recipeImageView.bottomAnchor.constraint(equalTo: recipeTitle.topAnchor, constant: 0),

            recipeTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            recipeTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            recipeTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ListRecipeTableViewCell {

    func updateCell(with viewModel: RecipeCellModel?){
        let placeholder = UIImage()
        if let url = viewModel?.imageURL{
            recipeImageView.image = placeholder
            let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
            recipeImageView.kf.setImage(with: resource)
        }
    
        recipeTitle.text = viewModel?.title
    }
}
