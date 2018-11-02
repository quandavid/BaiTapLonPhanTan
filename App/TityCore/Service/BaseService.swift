//
//  BaseService.swift
//  SotatekCore
//
//  Created by Thanh Tran on 9/8/16.
//  Copyright © 2016 SotaTek. All rights reserved.
//

import Foundation

open class BaseService: Observer {
    var notifier = Notifier.serviceNotifier
    
    func notifyObservers(_ command: Int, data: Any? = nil) {
        notifier.notifyObservers(command, data: data)
    }
    
    public func addObserver(_ observer: Observer) {
        notifier.addObserver(observer)
    }
    
    public func removeObserver(_ observer: Observer) {
        notifier.removeObserver(observer)
    }
    
    open func update(_ command: Int, data: Any?) {
        switch command {
            
        default:
            break
        }
    }
    

}
