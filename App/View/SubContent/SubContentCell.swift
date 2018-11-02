//
//  SubContentCell.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/3/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

class SubContentCell: AppTableViewCell {
    @IBOutlet var authorName: UILabel!
    
    @IBOutlet var createTime: UILabel!
    
    @IBOutlet var content: UILabel!
    
    var subContent: SubContent! {
        didSet {
            self.authorName.text = subContent.author
            self.createTime.text = "\(subContent.startTime) - \(subContent.endTime)"
            self.content.text = subContent.content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        content.numberOfLines = 0
        content.sizeToFit()
        // Initialization code
    }

    
}
