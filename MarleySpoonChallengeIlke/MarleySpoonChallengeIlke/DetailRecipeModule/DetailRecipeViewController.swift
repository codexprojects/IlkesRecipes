//
//  DetailRecipeViewController.swift
//  MarleySpoonChallengeIlke
//
//  Created by Ilke Yucel on 5.09.2021.
//

import UIKit
import Kingfisher

final class DetailRecipeViewController: UIViewController {
    
    // MARK: - CollectionView Section Enum
    
    enum Section {
        case title
        case chefName
        case tags
        case description
    }
  
    init(viewModel: DetailRecipeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Not supported!")
    }
    
    // MARK: - Class Variables
    
    private var viewModel: DetailRecipeViewModel!
    private var dataSource: UICollectionViewDiffableDataSource<Section, DetailsCellViewModel>! = nil
  
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureDataSource()
    }
        
    override func loadView() {
        super.loadView()
        self.view = self.viewModel?.detailRecipeView
    }
}

extension DetailRecipeViewController {
    
    private func configureUI(){
        ///imageView
        
        let placeholder = UIImage()
        if let url = viewModel?.imageURL{
            let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
            self.viewModel.detailRecipeView.recipeImage.kf.setImage(with: resource, placeholder: placeholder, options: [.transition(.fade(0.2))], progressBlock: nil) { _ in }
        }
        
        ///collectionView
        self.viewModel.detailRecipeView.recipeDetailsCollectionView.register(UINib(nibName:"DetailRecipeCell", bundle: nil), forCellWithReuseIdentifier: "DetailRecipeCell")
        self.viewModel.detailRecipeView.recipeDetailsCollectionView.collectionViewLayout = generateLayout()
    }
    
    // MARK: - CollectionView DataSource Functions
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, DetailsCellViewModel>(collectionView: self.viewModel.detailRecipeView.recipeDetailsCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, viewModel: DetailsCellViewModel) -> UICollectionViewCell? in

            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "DetailRecipeCell",
                    for: indexPath) as? DetailRecipeCell else { fatalError("Could not create new cell") }
            cell.text = viewModel.text
            cell.sectionType = self.viewModel.sections[indexPath.section]
            return cell
        }
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, DetailsCellViewModel> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DetailsCellViewModel>()
        
        if viewModel.titleCellViewModel.text != nil {
            snapshot.appendSections([Section.title])
            snapshot.appendItems([viewModel.titleCellViewModel])
        }
        
        if viewModel.chefNameCellViewModel.text != nil {
            snapshot.appendSections([Section.chefName])
            snapshot.appendItems([viewModel.chefNameCellViewModel])
        }
        
        if let tagsCellViewModels = viewModel.tagsCellViewModels{
            snapshot.appendSections([Section.tags])
            snapshot.appendItems(tagsCellViewModels)
        }
        
        if viewModel.descriptionCellViewModel.text != nil {
            snapshot.appendSections([Section.description])
            snapshot.appendItems([viewModel.descriptionCellViewModel])
        }
        
        return snapshot
    }
    
    // MARK: - CollectionView Layout Functions
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = self?.viewModel.sections[sectionIndex]
            switch (sectionLayoutKind) {
            case .tags: return self?.generateTagsLayout()
            default: return self?.generateDefaultLayout()
            }
        }
        return layout
    }
    
    private func generateDefaultLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(10))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
        return section
    }
    
    private func generateTagsLayout() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .estimated(10), heightDimension: .estimated(10))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.edgeSpacing = .init(leading: .fixed(8), top: nil, trailing: nil, bottom: nil)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
        return section
    }
}
