//
//  MeetingCell.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/3/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

class MeetingCell: AppTableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var createdLabel: UILabel!
    
    var meetingModel: MeetingModel! {
        didSet {
            titleLabel.text = meetingModel.title
            createdLabel.text = self.convertDate(date: meetingModel.createdAt)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func convertDate(date: String) -> String {
        guard date != "" else {
            return ""
        }
//        let str = date.replacingOccurrences(of: ".", with: "+")
//        let str2 = str.replacingOccurrences(of: "Z", with: "")
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
        
        let dateInfo = "\(strMonth) \(strYear)"
        
        return dateInfo
    }

    
}
