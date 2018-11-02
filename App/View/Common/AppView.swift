//
//  AppView.swift
//  Drpedia
//
//  Created by Quan Nguyen Dinh on 12/7/17.
//  Copyright © 2017 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import UIKit

extension UIView: AppObserver {
    @nonobjc
    func notifyObservers(_ command: Command, data: Any? = nil) {
        Notifier.viewNotifier.notifyObservers(command.rawValue, data: data)
    }
    @objc
    public func update(_ command: Command, data: Any?) {}
}
