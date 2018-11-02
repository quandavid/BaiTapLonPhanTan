//
//  AppController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 10/9/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import RxSwift

class AppController : BaseController {
    let homeService = HomeService()
    var disposeBag: DisposeBag!
    
    required override init() {
        disposeBag = DisposeBag()
    }
    
    func notifyObservers(_ command: Command, data: Any? = nil) {
        notifier.notifyObservers(command.rawValue, data: data)
    }
    
    public override func update(_ command: Int, data: Any?) {
        self.update(Command(rawValue: command)!, data: data)
    }
    
    func update(_ command: Command, data: Any?) {
        
    }
    
    func dispose() {
        disposeBag = nil
    }
    
}
