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

class SubContentModel: Object {
    @objc dynamic var subId: Int = 0
    @objc dynamic var author: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var startTime: String = ""
    @objc dynamic var endTime: String = ""
    @objc dynamic var flag: Int = 0
    @objc dynamic var isFull: Int = 0
    @objc dynamic var userId: Int = 0
    @objc dynamic var meetingId: Int = 0
    
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
        self.flag = json["flag"].intValue
        self.isFull = json["is_full"].intValue
        self.userId = json["user_id"].intValue
        self.meetingId = json["meeting_id"].intValue
    }
    
    func convertToDictionaryFull() -> [String: Any] {
        var dic: [String: Any] = [:]
        dic["author"] = self.author
        dic["content"] = self.content
        dic["start_time"] = self.startTime
        dic["end_time"] = self.endTime
        return dic
    }
    
    func convertToDictionaryLeakAuthor() -> [String: Any] {
        var dic: [String: Any] = [:]
        dic["content"] = self.content
        dic["start_time"] = self.startTime
        dic["end_time"] = self.endTime
        return dic
    }
    
    func convertToDictionaryLeakContent() -> [String: Any] {
        var dic: [String: Any] = [:]
        dic["author"] = self.author
        dic["start_time"] = self.startTime
        dic["end_time"] = self.endTime
        return dic
    }
}
