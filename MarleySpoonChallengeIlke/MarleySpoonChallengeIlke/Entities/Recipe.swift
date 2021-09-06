//
//  Recipe.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import Foundation
import Contentful

public class Recipe: EntryDecodable, FieldKeysQueryable {
    
    public static let contentTypeId: String = ContentTypeQuery.recipe.rawValue
    
    public let id: String
    public let localeCode: String?
    public let updatedAt: Date?
    public let createdAt: Date?
    
    let title: String?
    let description: String?
    
    var photo: Asset?
    var chef: Chef?
    var tags: [Tag]?
    
    public required init(from decoder: Decoder) throws {
        let sys = try decoder.sys()
        
        id = sys.id
        localeCode = sys.locale
        updatedAt = sys.updatedAt
        createdAt = sys.createdAt
        
        let fields = try decoder.contentfulFieldsContainer(keyedBy: Recipe.FieldKeys.self)
        
        self.title = try fields.decodeIfPresent(String.self, forKey: .title)
        self.description = try fields.decodeIfPresent(String.self, forKey: .description)
        
        try fields.resolveLink(forKey: .photo, decoder: decoder) { [weak self] image in
            self?.photo = image as? Asset
        }
        
        try fields.resolveLink(forKey: .chef, decoder: decoder) { [weak self] chef in
            self?.chef = chef as? Chef
        }

        try fields.resolveLinksArray(forKey: .tags, decoder: decoder) { [weak self] tags in
            self?.tags = tags as? [Tag]
        }
    }
    
    public enum FieldKeys: String, CodingKey {
        case title, description, photo, chef, tags
    }
}
