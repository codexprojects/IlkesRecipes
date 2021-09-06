//
//  DetailRecipeCell.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 6.09.2021.
//

import UIKit

class DetailRecipeCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    
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

