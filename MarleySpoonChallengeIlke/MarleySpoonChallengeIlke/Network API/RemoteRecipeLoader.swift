//
//  RemoteRecipeLoader.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import Foundation
import Contentful

public final class RemoteRecipeLoader: RecipeLoader {
    
    private let queryString: String
    
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
    
    public init(queryString: String) {
        self.queryString = queryString
    }
}

extension RemoteRecipeLoader {
    
    public func loadAllRecipes(completion: @escaping LoadReceipeResult){
        let query = QueryOn<Recipe>.where(contentTypeId: queryString)

        client.fetchArray(of: Recipe.self, matching: query) { [weak self] result in
            
            guard self != nil else { return }
            
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
