//
//  HistoryModel.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/25/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class HistoryModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var action: String = ""
    @objc dynamic var meetingId: Int = 0
    @objc dynamic var column: String = ""
    @objc dynamic var oldValue: String = ""
    @objc dynamic var newValue: String = ""
    @objc dynamic var changeBy: String = ""
    @objc dynamic var updatedAt: String = ""
    @objc dynamic var createdAt: String = ""
    convenience init(json: JSON) {
        self.init()
        if json.isEmpty {
            return
        }
        self.id = json["id"].intValue
        self.meetingId = json["meeting_id"].intValue
        self.action = json["action"].stringValue
        self.column = json["column"].stringValue
        self.oldValue = json["old_value"].stringValue
        self.newValue = json["new_value"].stringValue
        self.changeBy = json["change_by"].stringValue
        self.updatedAt = json["updated_at"].stringValue
        self.createdAt = json["created_at"].stringValue
        
    }
}

