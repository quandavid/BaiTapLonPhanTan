//
//  AppService.swift
//  BaseCore
//
//  Created by Quan Nguyen Dinh on 1/2/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation

class AppService: BaseService, AppObserver {
    
    func update(_ command: Command, data: Any?) {}
    
    func notifyObservers(_ command: Command, data: Any? = nil) {
        notifier.notifyObservers(command.rawValue, data: data)
    }
    
    override func update(_ command: Int, data: Any?) {
        super.update(command, data: data)
        self.update(Command(rawValue: command)!, data: data)
    }
}
