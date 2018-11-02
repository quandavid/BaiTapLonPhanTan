//
//  AppViewController.swift
//  JetFri
//
//  Created by Quan Nguyen Dinh on 6/9/18.
//  Copyright © 2018 UpPlus. All rights reserved.
//

import UIKit

class AppViewController: BaseViewController, AppObserver {
    func update(_ command: Command, data: Any?) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

extension AppViewController {
    func showViewController(_ id: AppViewController.Type, data: [String: Any] = [String: Any]()) {
        let vc = ViewControllerFactory.createViewController(type: id)
        vc.initData = data
        self.present(vc, animated: true, completion: nil)
    }
    
    func pushViewController(_ id: AppViewController.Type, data: [String: Any] = [String: Any]()) {
        let vc = ViewControllerFactory.createViewController(type: id)
        vc.initData = data
        (self.tabBarController?.selectedViewController as? UINavigationController)?.pushViewController(vc, animated: true)
    }
}



