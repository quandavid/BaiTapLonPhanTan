//
//  AppCollectionViewCell.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 10/11/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import UIKit

class AppCollectionViewCell: BaseCLCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
        initLayouts()
    }
    
    func initSubViews() {}
    func initLayouts() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
