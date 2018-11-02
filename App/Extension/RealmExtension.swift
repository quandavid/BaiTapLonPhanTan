//
//  RealmExtension.swift
//  Electrician
//
//  Created by luckymanbk on 8/30/16.
//  Copyright © 2016 Paditech. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
extension RealmSwift.List {
    
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
extension Object {
    func toDictionary() -> NSDictionary {
        let properties = self.objectSchema.properties.map { $0.name }
        let dicProps = self.dictionaryWithValues(forKeys: properties)
        
        let mutabledic = NSMutableDictionary()
        mutabledic.setValuesForKeys(dicProps)
        
        for prop in self.objectSchema.properties as [Property] {
            
            if prop.objectClassName != nil  {
                if let nestedObject = self[prop.name] as? Object {
                    mutabledic.setValue(nestedObject.toDictionary(), forKey: prop.name)
                } else if let nestedListObject = self[prop.name] as? ListBase {
                    var objects = [AnyObject]()
                    for index in 0..<nestedListObject._rlmArray.count  {
                        if let object = nestedListObject._rlmArray[index] as? Object {
                            objects.append(object.toDictionary())
                        }
                    }
                    mutabledic.setObject(objects, forKey: prop.name as NSCopying)
                }
            }
        }
        return mutabledic
    }
}
