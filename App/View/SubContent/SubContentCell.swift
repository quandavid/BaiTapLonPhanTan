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
    @IBOutlet var endTime: UILabel!
    @IBOutlet var status: UIView!
    
    @IBOutlet var content: UITextView!
    
    var subContent: SubContentModel! {
        didSet {
            self.authorName.text = "Author: \(subContent.author)"
            self.createTime.text = "Start time: \(convertDate(date: subContent.startTime))"
            self.endTime.text = "End time: \(convertDate(date: subContent.endTime))"
            self.content.text = subContent.content
            DispatchQueue.main.async {
                if self.subContent.flag == 1 {
                    self.status.backgroundColor = .red
                } else if self.subContent.isFull == 0 {
                    self.status.backgroundColor = .blue
                } else {
                    self.status.backgroundColor = .white
                }
            }
           
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        content.delegate = self
        self.status.layer.cornerRadius = 13
        self.status.layer.masksToBounds = true
        // Initialization code
    }
    
    func convertDate(date: String) -> String {
        guard date != "" else {
            return ""
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        var someDate = dateFormatter.date(from: date)
        if someDate == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.ssZ"
            someDate = dateFormatter.date(from: date)
        }
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MMM"
        let strMonth = dateFormatter2.string(from: someDate!)
        dateFormatter2.dateFormat = "dd"
        let strYear = dateFormatter2.string(from: someDate!)
        dateFormatter2.dateFormat = "HH:mm:ss"
        let strDay = dateFormatter2.string(from: someDate!)
        let dateInfo = "\(strYear) \(strMonth) \(strDay)"
        
        return dateInfo
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
