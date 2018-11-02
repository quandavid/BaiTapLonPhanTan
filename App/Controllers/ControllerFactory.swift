//
//  ControllerFactory.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 10/9/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation

protocol ControllerProtocol {
    func createController()
}

class ControllerFactory {
    class func createController(type: AppController.Type, for controllerManager: ControllerManager) -> AppController! {
        let controller = type.init()
        controllerManager.addController(controller)
        return controller
    }
}


