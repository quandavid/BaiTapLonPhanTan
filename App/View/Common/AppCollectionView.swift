//
//  AppCollectionView.swift
//  JetFri
//
//  Created by Quan Nguyen Dinh on 6/10/18.
//  Copyright © 2018 UpPlus. All rights reserved.
//

import Foundation
import UIKit

class AppCollectionView: UICollectionView {
    override func viewDidAppear(_ data: Any?) {
        super.viewDidAppear()
        self.dataSource = self
        self.delegate = self
    }
}

extension AppCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fatalError("Please implement method: numberOfItemsInSection")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("Please implement method: cellForItemAt")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        fatalError("Please implement method: sizeForItemAt")
    }
    
    
    
    
}
