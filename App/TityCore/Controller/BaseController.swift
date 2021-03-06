//
//  BaseController.swift
//  SotatekCore
//
//  Created by Thanh Tran on 9/8/16.
//  Copyright © 2016 SotaTek. All rights reserved.
//

import Foundation
import RxSwift

open class BaseController: Observer {
    var notifier = Notifier.controllerNoitfier
    
    init() {
        Notifier.serviceNotifier.addObserver(self)
    }
    
    func notifyObservers(_ command: Int, data: Any? = nil) {
        notifier.notifyObservers(command, data: data)
    }
    
    public func addObserver(_ observer: Observer) {
        notifier.addObserver(observer)
    }
    
    public func removeObserver(_ observer: Observer) {
        notifier.removeObserver(observer)
    }
    
    public func update(_ command: Int, data: Any?) {}
    
    func initialize() {
        
    }
}
