//
//  Notifier.swift
//  SotatekCore
//
//  Created by Thanh Tran on 9/8/16.
//  Copyright © 2016 SotaTek. All rights reserved.
//

import Foundation

open class Notifier {
    //open static let SERVICE_NOTIFIER = "service"
    //open static let CONTROLLER_NOTIFIER = "controller"
    
    public static let viewNotifier = Notifier.instance("view")
    public static let controllerNoitfier = Notifier.instance("controller")
    public static let serviceNotifier = Notifier.instance("service")
    public static let repositoryNotifier = Notifier.instance("repository")
    
    fileprivate static var instances = [String: Notifier]()
    public static func instance(_ name: String) -> Notifier {
        var instance = instances[name]
        if instance == nil {
            instance = Notifier()
            instances[name] = instance
        }
        return instance!
    }

    public static func removeInstance(_ name: String) {
        instances[name] = nil
    }
    
    var observers = [Observer]()
    
    init() {
    }
    
    func addObserver(_ observer: Observer) {
        if observers.index(where: {$0 === observer}) == nil {
            observers.append(observer)
        }
    }
    
    func removeObserver(_ observer: Observer) {
        if let index = observers.index(where: {$0 === observer}) {
            observers.remove(at: index)
        }
    }
    
    func notifyObservers(_ command: Int, data: Any? = nil) {
        for observer in observers {
            observer.update(command, data: data)
        }
    }
}
