//
//  DetailCellViewModel.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import Foundation

final class DetailsCellViewModel: Hashable {
    private let id = UUID()
    let text: String?
    
    init(text: String?) {
        self.text = text
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: DetailsCellViewModel, rhs: DetailsCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
