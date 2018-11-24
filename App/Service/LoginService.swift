//
//  LoginService.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/1/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import RxSwift

class LoginService: AppService {
    let loginRequest = RequestFactory.loginRequest
    
    func getUserData( email: String, password: String) -> Observable<UserModel> {
        return loginRequest.getUserData(email: email, password: password).flatMap { (response: HttpResponse) -> Observable<UserModel> in
            if let accessToken = response.data["token"].string {
                standardUserDefaults.set(accessToken, forKey: kAccessToken)
            }
            let userModel = UserModel(json: response.data)
            return Observable<UserModel>.create({ (subscribe)  in
                
                if response.data.count == 0 {
                    subscribe.onError(HandingError.loginFailed)
                } else {
                    subscribe.onNext(userModel)
                    subscribe.onCompleted()
                }
                return Disposables.create()
            })
        }
    }
}

enum HandingError: Error {
    case loginFailed
    case badRequest
}
