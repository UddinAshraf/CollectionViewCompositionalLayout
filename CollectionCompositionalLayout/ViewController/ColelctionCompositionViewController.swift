//
//  ColelctionCompositionViewController.swift
//  CollectionCompositionalLayout
//
//  Created by Ashraf Uddin on 6/11/23.
//

/*
 This ViewController is implemented for practising UICollectionView Compositional Layout.
 Links reference:
 //https://medium.com/@oradwan037/the-power-of-uicollectionview-compositional-layout-swift-uikit-ec2d817eb15c
 //https://www.appcoda.com/diffable-data-source/
 //https://hackernoon.com/implementing-uicollectionview-compositional-layout-with-pinterest-section
 */

import UIKit

class ColelctionCompositionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var dataSource = configureDataSource()
    lazy var layout: UICollectionViewCompositionalLayout? = UICollectionViewCompositionalLayout { sectionIndex, environment in
        
        guard let sectionType = Section(rawValue: sectionIndex) else { return nil}
        
        switch sectionType {
        case .horizontalGrid:
            return self.horizontalGridSection()
        case .verticalGrid:
            return self.verticalGridSection()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let layout else { return }
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        collectionView.dataSource = dataSource
        collectionView.setCollectionViewLayout(layout, animated: true)
        applyDataSource(with: DataManger.shared.horizontalGrids, verticalGrids: DataManger.shared.verticalGrids, animatingDifferences: true)
        
    }
    
    private func applyDataSource(with horizontalGrids: [HorizontalGridModel], verticalGrids: [VerticalGridModel], animatingDifferences: Bool) {
        var snapShot = DataSourceSnapshot()
        snapShot.deleteAllItems()
        snapShot.appendSections(Section.allCases)
        
        snapShot.appendItems(horizontalGrids.map{ SectionItems.horizontalGrid($0)}, toSection: .horizontalGrid)
        snapShot.appendItems(verticalGrids.map{ SectionItems.verticalGrid($0)}, toSection: .verticalGrid)
        dataSource.apply(snapShot, animatingDifferences: animatingDifferences)
        
    }
    
    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: self.collectionView) { collectionView, indexPath, sectionItems in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompositionalGridCell.id, for: indexPath) as? CompositionalGridCell else { return UICollectionViewCell() }
            
            switch sectionItems {
            case .horizontalGrid(let model):
                cell.titleLabel.text = "HG - \(model.name)"
            case .verticalGrid(let model):
                cell.titleLabel.text = "VG - \(model.name)"
            }
            
            return cell
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader, let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as?
                    SectionHeaderView, let sectionType = Section(rawValue: indexPath.section) else { return UICollectionReusableView() }
            switch sectionType {
            case .horizontalGrid:
                headerView.titleLabel.text = "Horizontal Cards"
            case .verticalGrid:
                headerView.titleLabel.text = "Vertical Grid"
            }
            return headerView
        }
        return dataSource
    }
    
    
    private func horizontalGridSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(225))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                      , bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20
                                                        , bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func verticalGridSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
}
