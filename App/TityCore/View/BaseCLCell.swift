//
//  BaseCLCell.swift
//  BaseSwift
//
//  Created by Quynh Nguyen on 6/18/17.
//  Copyright © 2017 Quynh Nguyen. All rights reserved.
//

import UIKit

class BaseCLCell: UICollectionViewCell {
    
    // MARK: define for cell
    static func identifier() -> String {
        return String(describing: self.self)
    }
    
    static func size() -> CGSize {
        return CGSize.zero
    }
    
    static func registerCellByClass(_ collectionView: UICollectionView) {
        collectionView.register(self.self, forCellWithReuseIdentifier: self.identifier())
    }
    
    static func registerCellByNib(_ collectionView: UICollectionView) {
        let nib = UINib(nibName: self.identifier(), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: self.identifier())
    }
    
    static func loadCell(_ collectionView: UICollectionView, path: IndexPath) -> BaseCLCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier(), for: path) as! BaseCLCell
    }
    
}
