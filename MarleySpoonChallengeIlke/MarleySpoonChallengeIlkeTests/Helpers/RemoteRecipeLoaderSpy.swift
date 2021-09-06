//
//  RemoteRecipeLoaderSpy.swift
//  MarleySpoonChallengeIlkeTests
//
//  Created by Ilke Yucel on 6.09.2021.
//

import MarleySpoonChallengeIlke
import Foundation
import Contentful

class RemoteRecipeLoaderSpy: Client {
    private var messages = [(query: String, completion: (LoadReceipeResult) -> Void)]()

    var requestedQueries: [String] {
        return messages.map{ $0.query}
    }

    func loadAllRecipes(with query:String, completion: @escaping (LoadReceipeResult) -> Void) {
        messages.append((query, completion))
    }

}
