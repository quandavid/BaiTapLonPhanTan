//
//  BaseStorage.swift
//  JetFri
//
//  Created by Quan Nguyen Dinh on 6/9/18.
//  Copyright © 2018 UpPlus. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON
import Realm

public typealias DataIdType = String

class BaseStorage<T: Object> {
    
    init() {
    }
    
    open func save(_ entity: T) {
        let db = try! Realm()
            db.beginWrite()
            do {
                db.add(entity, update: true)
                try db.commitWrite()
            } catch let error {
                BLogError(error.localizedDescription)
                db.cancelWrite()
            }
        
    }
    
    open func create(_ dict: [String: Any]) {
        let db = try! Realm()
        db.beginWrite()
        do {
            db.create(T.self, value: dict, update: true)
            try db.commitWrite()
        } catch let error {
            BLogError(error.localizedDescription)
            db.cancelWrite()
        }
    }
    
    open func remove(_ id: DataIdType) -> Bool {
        let db = try! Realm()
        if let entity = get(id) {
            db.beginWrite()
            do {
                db.delete(entity)
                try db.commitWrite()
                return true
            } catch let error {
                BLogError(error.localizedDescription)
                db.cancelWrite()
                return false
            }
        }else {
            return false
        }
    }
    
    open func remove(_ entity: T) -> Bool {
        let db = try! Realm()
            db.beginWrite()
            do {
                db.delete(entity)
                try db.commitWrite()
                return true
            } catch let error {
                BLogError(error.localizedDescription)
                db.cancelWrite()
                return false
            }
    }
    
    open func get(_ id: DataIdType) -> T? {
        let db = try! Realm()
        if let filter = db.objects(T.self).filter("id = \(id)").first {
            return filter
        }
        return nil
        
    }

    open func getAll() ->  [T]? {
        let db = try! Realm()
        if db.objects(T.self).toArray(type: T.self).count > 0 {
            return db.objects(T.self).toArray(type: T.self)
        }
        return nil
    }
    func getList(query: String = "") -> [T] {
        let db = try! Realm()
        var results: Results<T>
        if query != "" {
            results = db.objects(T.self).filter(query)
        }else {
            results = db.objects(T.self)
        }
        
        var data: [T] = []
        for element in results {
            data.append(element)
        }
        return data
    }
    
    func removeObject(id: Int, keyId: String) {
        let db = try! Realm()
        guard let object = db.objects(T.self).filter("\(keyId) == \(id)").first else { return }
        db.beginWrite()
        do {
            db.delete(object)
            try db.commitWrite()
        } catch let error {
            BLogError(error.localizedDescription)
            db.cancelWrite()
        }
    }
    
    func getList(query: String, sorted: [SortDescriptor]) -> [T] {
        let db = try! Realm()
        var results: Results<T>
        if query != "" {
            results = db.objects(T.self).filter(query).sorted(by: sorted)
        }else {
            results = db.objects(T.self).sorted(by: sorted)
        }
        
        var data: [T] = []
        for element in results {
            data.append(element)
        }
        return data
    }
    
    open func clear() {
        let db = try! Realm()
        db.beginWrite()
        do {
            db.deleteAll()
            try db.commitWrite()
        } catch let error {
            BLogError(error.localizedDescription)
            db.cancelWrite()
        }
    }
    
}


