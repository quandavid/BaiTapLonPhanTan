//
//  HistoryRequest.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/25/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import RxSwift

class HistoryRequest: AppRequest {
    func getHistory() -> Observable<HttpResponse> {
        let token = standardUserDefaults.string(forKey: kAccessToken)!
        let params : [String: Any] = [:]
        return self.getAll(url: "histories?token=\(token)", options: params)
    }
}
