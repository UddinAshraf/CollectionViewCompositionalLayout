//
//  CollectionCompositionalLayout.swift
//  CollectionCompositionalLayout
//
//  Created by Ashraf Uddin on 6/11/23.
//

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
