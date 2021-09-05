//
//  RecipeCellModel.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import Foundation

final class RecipeCellModel{
    let title: String?
    let imageURL: URL?
    
    init(recipe: Recipe) {
        self.title = recipe.title
        self.imageURL = recipe.photo?.file?.url
    }
}
