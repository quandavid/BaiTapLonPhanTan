//
//  UserModel.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/1/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class UserModel: Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
    
    override static func primaryKey() -> String? {
        return "userId"
    }
    
    convenience init(json: JSON) {
        self.init()
        if json.isEmpty {
            return
        }
        self.userId = json["id"].intValue
        self.name = json["name"].stringValue
        self.email = json["email"].stringValue
        self.password = json["password"].stringValue
    }
}
