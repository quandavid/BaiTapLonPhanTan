//
//  LoginController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/1/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation

class LoginController: AppController {
    let loginService = LoginService()
    
    func getUserData( email: String, password: String) {
        loginService.getUserData(email: email, password: password).subscribe(onNext: {[weak self] userModel in
            guard let this = self else { return }
            this.notifyObservers(.Login_loginSuccess, data: userModel)
        }, onError: { [weak self] (error) in
            guard let this = self else { return }
            print(error)
            this.notifyObservers(.Login_loginFail)
        }).disposed(by: disposeBag)
    }
}
