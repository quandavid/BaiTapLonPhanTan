//
//  HistoryService.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/25/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import RxSwift

class HistoryService: AppService {
    let historyRequest = RequestFactory.historyRequest
    
    func getHistory() -> Observable<[HistoryModel]> {
        return historyRequest.getHistory().flatMap({ (response) -> Observable<[HistoryModel]> in
            let histories = response.data.arrayValue.map { HistoryModel(json: $0) }
            return Observable<[HistoryModel]>.create({ subscribe in
                if histories.count == 0 {
                    subscribe.onError(HandingError.getHistoryFailure)
                } else {
                    subscribe.onNext(histories)
                    subscribe.onCompleted()
                }
                return Disposables.create()
            })
        })
    }
}
