//
//  SubContentCell.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/3/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

class SubContentCell: AppTableViewCell {
    var updatedText: ((_ text: String) -> ())?
    
    @IBOutlet var authorName: UILabel!
    
    @IBOutlet var createTime: UILabel!
    
    @IBOutlet var content: UITextView!
    
    var subContent: SubContentModel! {
        didSet {
            self.authorName.text = subContent.author
            self.createTime.text = "\(subContent.startTime) - \(subContent.endTime)"
            self.content.text = subContent.content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        content.delegate = self
        // Initialization code
    }

    
}

extension SubContentCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if let block = updatedText {
            block(content.text)
        }
        content.resignFirstResponder()
    }
}
