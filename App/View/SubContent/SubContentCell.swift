//
//  SubContentCell.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/3/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit
import Kingfisher

class SubContentCell: AppTableViewCell {
    var updatedText: ((_ text: String) -> ())?
    @IBOutlet var avtarView: UIView!
    @IBOutlet var bubbleView: UIView!
    @IBOutlet var avtImage: UIImageView!
    
    @IBOutlet var authorName: UILabel!
    
    @IBOutlet var createTime: UILabel!
    @IBOutlet var status: UILabel!
    
    @IBOutlet var content: UITextView!
    
    var subContent: SubContentModel! {
        didSet {
            self.authorName.text = subContent.author
            self.createTime.text = "\(getDate(date: subContent.startTime)) From \(convertDate(date: subContent.startTime)) To \(convertDate(date: subContent.endTime))"
            self.content.text = subContent.content
            let avtUrl = "https://ui-avatars.com/api/?name="
            let dataURL = "\(avtUrl) \(subContent.author)"
            let text = dataURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            self.avtImage.kf.setImage(with: URL(string: text!))
            DispatchQueue.main.async {
                if self.subContent.flag == 1 {
//                    self.content.isEditable = false
                    self.status.text = "Record is conflicting"
                } else if self.subContent.isFull == 0 {
//                    self.content.isEditable = true
                    self.status.text = "Record is missing content"
                } else {
//                    self.content.isEditable = true
                    self.status.text = ""
                }
            }
           
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        content.delegate = self
        content.textColor = .white
        self.selectionStyle = .none
        bubbleView.layer.masksToBounds = true
        bubbleView.layer.cornerRadius = 8
        avtarView.layer.masksToBounds = true
        avtarView.layer.cornerRadius = 25
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
        dateFormatter2.dateFormat = "HH:mm:ss"
        let strDay = dateFormatter2.string(from: someDate!)
        let dateInfo = "\(strDay)"
        
        return dateInfo
    }
    
    func getDate(date: String) -> String {
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
        let dateInfo = "\(strYear) \(strMonth)"
        
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
