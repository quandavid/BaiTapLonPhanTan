//
//  ViewControllerFactory.swift
//  JetFri
//
//  Created by Quan Nguyen Dinh on 6/12/18.
//  Copyright © 2018 UpPlus. All rights reserved.
//

import Foundation

class ViewControllerFactory {
    static public func createViewController(type : AppViewController.Type) -> AppViewController {
        if (checkXibFileIsExist(filename: String(describing: type))) {
            return AppViewController(nibName: String(describing: type), bundle: nil)
        } else {
            return type.init()
        }
    }
}

extension ViewControllerFactory {
   static fileprivate func checkXibFileIsExist(filename name: String) -> Bool {
        guard (Bundle.main.path(forResource: name, ofType: "xib") != nil) else { return false }
        return true
    }
}
