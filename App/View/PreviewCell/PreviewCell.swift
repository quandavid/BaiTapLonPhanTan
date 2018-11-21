//
//  PreviewCell.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/21/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

class PreviewCell: AppTableViewCell {
    @IBOutlet var authorName: UILabel!
    
    @IBOutlet var createTime: UILabel!
    @IBOutlet var endTime: UILabel!
    
    @IBOutlet var content: UITextView!
    
    var subContent: SubContentModel! {
        didSet {
            self.authorName.text = subContent.author
            self.createTime.text = "Start time: \(subContent.startTime)"
            self.endTime.text = "End time: \(subContent.endTime)"
            self.content.text = subContent.content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
