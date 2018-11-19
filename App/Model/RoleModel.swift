//
//  RoleModel.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/8/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class RoleModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var role: Int = 0
    @objc dynamic var userId: Int = 0
    @objc dynamic var meetingId: Int = 0
    
    convenience init(json: JSON) {
        self.init()
        if json.isEmpty {
            return
        }
        self.id = json["id"].intValue
        self.role = json["role"].intValue
        self.userId = json["user_id"].intValue
        self.meetingId = json["meeting_id"].intValue
    }
}
