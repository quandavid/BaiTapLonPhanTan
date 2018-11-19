//
//  AppViewController.swift
//  JetFri
//
//  Created by Quan Nguyen Dinh on 6/9/18.
//  Copyright © 2018 UpPlus. All rights reserved.
//

import UIKit

class AppViewController: BaseViewController, AppObserver {
    public override func update(_ command: Int, data: Any?) {
        DispatchQueue.main.async {
            self.update(Command(rawValue: command)!, data: data)
        }
    }
    
    @nonobjc
    func update(_ command: Command, data: Any?) {
        switch command {
        case .C_ShowError:
            // do something
            break
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

extension AppViewController {
    func showViewController(_ id: AppViewController.Type, data: [String: Any] = [String: Any]()) {
        let vc = ViewControllerFactory.createViewController(type: id)
        let navigationVC = UINavigationController(rootViewController: vc)
        vc.initData = data
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    func pushViewController(_ id: AppViewController.Type, data: [String: Any] = [String: Any]()) {
        let vc = ViewControllerFactory.createViewController(type: id)
        vc.initData = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



