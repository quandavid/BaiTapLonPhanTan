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
        let params : [String: Any] = ["email": email, "password": password]
        return self.create(url: "login", options: params)
    }
}
