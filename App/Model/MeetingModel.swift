//
//  MeetingModel.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/3/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class MeetingModel: Object {
    @objc dynamic var meetingId: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var userCreatedId: Int = 0
    @objc dynamic var createdAt: String = ""
    
    convenience init(json: JSON) {
        self.init()
        if json.isEmpty {
            return
        }
        self.meetingId = json["id"].intValue
        self.title = json["title"].stringValue
        self.userCreatedId = json["user_created_id"].intValue
        self.createdAt = json["created_at"].stringValue
    }
}
