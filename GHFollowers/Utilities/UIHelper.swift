//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-19.
//

import UIKit

enum UIHelper {
    static func createFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth/3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = .init(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
