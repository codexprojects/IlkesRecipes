//
//  RemoteRecipeLoaderAPI.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import Foundation
import Contentful

typealias RecipesCompletion = (Result<[Recipe], Error>) -> Void

protocol RemoteRecipeLoaderAPIProtocol {
    func fetchAllRecipes(completion: @escaping RecipesCompletion)
}

final class RemoteRecipeLoaderAPI {
    let contentTypeClasses: [EntryDecodable.Type] = [
        Recipe.self,
        Chef.self,
        Tag.self
    ]
    
    lazy var client: Client = {
        let contentfulApi = ContentfulAPI()
        return Client(spaceId: contentfulApi.spaceId,
                      accessToken: contentfulApi.accessToken,
                      contentTypeClasses: contentTypeClasses)
    }()
}

extension RemoteRecipeLoaderAPI: RemoteRecipeLoaderAPIProtocol {
    func fetchAllRecipes(completion: @escaping RecipesCompletion){
        let query = QueryOn<Recipe>.where(contentTypeId: "recipe")

        client.fetchArray(of: Recipe.self, matching: query) { result in
            switch result {
            case .success(let entriesArrayResponse):
                let recipes = entriesArrayResponse.items
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
