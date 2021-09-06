//
//  Tag.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import Foundation
import Contentful

final class Tag: EntryDecodable, FieldKeysQueryable {
    
    static let contentTypeId: String = ContentTypeQuery.tag.rawValue
    
    let id: String
    let localeCode: String?
    let updatedAt: Date?
    let createdAt: Date?
    
    let name: String?
    
    public required init(from decoder: Decoder) throws {
        let sys = try decoder.sys()
        
        id = sys.id
        localeCode = sys.locale
        updatedAt = sys.updatedAt
        createdAt = sys.createdAt
        
        let fields = try decoder.contentfulFieldsContainer(keyedBy: Tag.FieldKeys.self)
        
        self.name = try fields.decodeIfPresent(String.self, forKey: .name)
    }
    
    enum FieldKeys: String, CodingKey {
        case name
    }
}
