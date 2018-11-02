//
//  SubContent.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/3/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class SubContent: Object {
    @objc dynamic var subId: Int = 0
    @objc dynamic var author: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var startTime: String = ""
    @objc dynamic var endTime: String = ""
    
    convenience init (json: JSON) {
        self.init()
        if json.isEmpty {
            return
        }
        
        self.subId = json["id"].intValue
        self.author = json["author"].stringValue
        self.content = json["content"].stringValue
        self.startTime = json["start_time"].stringValue
        self.endTime = json["end_time"].stringValue
    }
}
