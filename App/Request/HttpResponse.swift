//
//  HttpResponse.swift
//  BaseCore
//
//  Created by Quan Nguyen Dinh on 12/26/17.
//  Copyright © 2017 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import SwiftyJSON

class HttpResponse: NSObject, NSCoding {
    var data: JSON!
    
    init(fromJson json: JSON!) {
        if json == nil {
            return
        }
        data = json["data"]
    }
    
    func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        if data != nil {
            dictionary["data"] = data
        }
        return dictionary
    }
    
    public func encode(with aCoder: NSCoder) {
        if data != nil {
            aCoder.encode(data, forKey: "data")
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        data = aDecoder.decodeObject(forKey: "data") as? JSON
    }
    
    
}
