//
//  ResolveTableViewCell.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/24/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

class ResolveTableViewCell: AppTableViewCell {
    @IBOutlet var checkbox: UIImageView!
    @IBOutlet var textLb: UILabel!
    var tapCheckBoxBlock: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkbox.isUserInteractionEnabled = true
        self.selectionStyle = .none
        checkbox.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCheckBox)))
        // Initialization code
    }
    
    @objc func tapCheckBox() {
        if let block = tapCheckBoxBlock {
            block()
        }
    }
    
}
