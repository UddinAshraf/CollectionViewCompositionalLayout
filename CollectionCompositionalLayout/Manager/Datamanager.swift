//
//  Datamanager.swift
//  CollectionCompositionalLayout
//
//  Created by Ashraf Uddin on 6/11/23.
//

import Foundation

class DataManger {
    
    static let shared = DataManger()
    
    private init() {
    }
    
    let horizontalGrids = [
        HorizontalGridModel(name: "A"),
        HorizontalGridModel(name: "B"),
        HorizontalGridModel(name: "C"),
        HorizontalGridModel(name: "D"),
        HorizontalGridModel(name: "E"),
        HorizontalGridModel(name: "F")
    ]
    
    let verticalGrids = [
        VerticalGridModel(name: "A"),
        VerticalGridModel(name: "B"),
        VerticalGridModel(name: "C"),
        VerticalGridModel(name: "D"),
        VerticalGridModel(name: "E"),
        VerticalGridModel(name: "F"),
        VerticalGridModel(name: "G"),
        VerticalGridModel(name: "H"),
        VerticalGridModel(name: "I"),
        VerticalGridModel(name: "J")
    ]
}
