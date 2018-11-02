//
//  AppObserver.swift
//  BaseCore
//
//  Created by Quan Nguyen Dinh on 12/27/17.
//  Copyright © 2017 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import UIKit

public protocol AppObserver: Observer {
    func update(_ command: Command, data: Any?)
}

extension AppObserver {
    public func update(_ command: Int, data: Any?) {
        self.update(Command(rawValue: command)!, data: data)
    }
}

extension AppObserver where Self: UIView {
    public func update(_ command: Int, data: Any?) {
        DispatchQueue.main.async {
            self.update(Command(rawValue: command)!, data: data)
        }
    }
}
