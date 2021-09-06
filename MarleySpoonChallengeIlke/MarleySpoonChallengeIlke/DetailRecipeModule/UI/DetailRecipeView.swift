//
//  DetailRecipeView.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import UIKit

class DetailRecipeView: UIView {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeDetailsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        recipeImage.backgroundColor = .green
        recipeDetailsCollectionView.backgroundColor = .red
        
    }
}
