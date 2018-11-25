//
//  LoginRequest.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/1/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import RxSwift

class LoginRequest: AppRequest {
    func getUserData( email: String, password: String) -> Observable<HttpResponse> {
        var params: [String: Any] = [:]
        params[Constant.RepositoryParam.requestParams] = ["email": email, "password": password]
        return self.create(url: "users/login", options: params)
    }
    
    func registerUser(name: String, email: String, password: String) -> Observable<HttpResponse> {
        var params: [String: Any] = [:]
        params[Constant.RepositoryParam.requestParams] = ["email": email, "password": password, "name": name]
        return self.create(url: "users/signup", options: params)
    }
}
