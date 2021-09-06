//
//  DetailRecipeViewModel.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import UIKit

final class DetailRecipeViewModel{
    private var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    let detailRecipeView: DetailRecipeView = DetailRecipeView.instantiateFromNib()!
    
    var sections: [DetailRecipeViewController.Section] {
        var sections: [DetailRecipeViewController.Section] = []
        if titleCellViewModel.text != nil {
            sections.append(.title)
        }
        if chefNameCellViewModel.text != nil {
            sections.append(.chefName)
        }
        if tagsCellViewModels != nil {
            sections.append(.tags)
        }
        if descriptionCellViewModel.text != nil {
            sections.append(.description)
        }
        return sections
    }
    
    var imageURL: URL?{
        recipe.photo?.url
    }
    
    var imageAspectRatio: Double{
        guard let width = recipe.photo?.file?.details?.imageInfo?.width,
              let height = recipe.photo?.file?.details?.imageInfo?.height
        else {
            return 1.33
        }
        return width / height
    }
    
    var titleCellViewModel: DetailsCellViewModel{
        DetailsCellViewModel(text: recipe.title)
    }
    
    var chefNameCellViewModel: DetailsCellViewModel{
        if let chefName = recipe.chef?.name{
            return DetailsCellViewModel(text: "Chef Name: " + chefName)
        }else{
            return DetailsCellViewModel(text: nil)
        }
    }
    
    var tagsCellViewModels: [DetailsCellViewModel]? {
        return recipe.tags?.map { DetailsCellViewModel(text: $0.name) }
    }
    
    var descriptionCellViewModel: DetailsCellViewModel{
        DetailsCellViewModel(text: recipe.description)
    }

}
