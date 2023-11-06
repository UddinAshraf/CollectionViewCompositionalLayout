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

enum Section: Int, CaseIterable {
    case horizontalGrid
    case verticalGrid
}

enum SectionItems: Hashable {
    case horizontalGrid(HorizontalGridModel)
    case verticalGrid(VerticalGridModel)
}

typealias DataSource = UICollectionViewDiffableDataSource<Section,SectionItems>
typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section,SectionItems>

class ColelctionCompositionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var dataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        return dataSource
    }
}

