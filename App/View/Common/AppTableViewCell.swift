//
//  AppTableViewCell.swift
//  JetFri
//
//  Created by Quan Nguyen Dinh on 6/9/18.
//  Copyright © 2018 UpPlus. All rights reserved.
//

import Foundation
import UIKit

class AppTableViewCell: BaseTBCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initSubViews()
        self.initLayouts()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func initSubViews() {
        
    }
    
    func initLayouts() {
        
    }
}
