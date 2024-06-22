//
//  HomeViewItemCollectionViewLayout.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import UIKit

class HomeViewItemCollectionViewLayout: UICollectionViewLayout {
    // MARK: - References / Properties
    // Sets the scrollable content size for items.
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else {
            return CGSize(width: 0, height: 0)
        }
        let contentHeight = collectionView.contentSize.height
        return CGSize(width: collectionView.bounds.width, height: contentHeight)
    }
    
}
