//
//  RecipeLoader.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import Foundation

typealias LoadReceipeResult = (Result<[Recipe], Error>) -> Void

protocol RecipeLoader {
    func loadAllRecipes(completion: @escaping LoadReceipeResult)
}
