//
//  StringExtension.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/5/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func convertDate() -> String {
        let str = self.replacingOccurrences(of: ".", with: "+")
        let str2 = str.replacingOccurrences(of: "Z", with: "")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let someDate = dateFormatter.date(from: str2)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MMM"
        let strMonth = dateFormatter2.string(from: someDate!)
        dateFormatter2.dateFormat = "dd"
        //        let strDay = dateFormatter2.string(from: someDate!)
        //        dateFormatter2.dateFormat = "HH"
        //        let strHour = dateFormatter2.string(from: someDate!)
        //        dateFormatter2.dateFormat = "mm"
        //        let strMinute = dateFormatter2.string(from: someDate!)
        //        dateFormatter2.dateFormat = "yyyy"
        let strYear = dateFormatter2.string(from: someDate!)
        
        let dateInfo = "\(strMonth) \(strYear)"
        
        return dateInfo
    }
}
