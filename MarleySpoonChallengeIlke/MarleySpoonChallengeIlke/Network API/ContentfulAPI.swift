//
//  ContentfulAPI.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import Foundation

public struct ContentfulAPI {
    
    let spaceId = "kk2bw5ojx476"
    let environmentId = "master"
    let accessToken = "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c"
}

public enum ContentTypeQuery: String {
    
    case recipe
    case chef
    case tag
}
