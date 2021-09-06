//
//  DetailsCells.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import UIKit

class DetailsCell: UICollectionViewCell {
    static let identifier = String(describing: DetailsCell.self)
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    var sectionType: DetailRecipeViewController.Section? {
        didSet{
            setupUI()
        }
    }
    
    var text: String?{
        didSet{
            textLabel.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // title label setup
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        guard let type = sectionType else { return }
        switch type {
        case .title:
            textLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            textLabel.numberOfLines = 0
            self.backgroundColor = .clear
            self.layer.cornerRadius = 0
        case .tags:
            textLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            textLabel.numberOfLines = 1
            self.backgroundColor = .systemGray5
            self.layer.cornerRadius = 8
        default:
            textLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            textLabel.numberOfLines = 0
            self.backgroundColor = .clear
            self.layer.cornerRadius = 0
        }
    }

}
