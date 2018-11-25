//
//  HistoryController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/25/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation

class HistoryController: AppController {
    let historyService = HistoryService()
    var histories: [HistoryModel] = []
    func getHistory() {
        historyService.getHistory().subscribe(onNext: {[weak self] (histories) in
            guard let this = self else { return }
            this.histories = histories
            this.notifyObservers(.History_GetSuccess)
            }, onError: {[weak self] (error) in
                guard let this = self else { return }
                this.notifyObservers(.History_GetFailure)
                print(error)
        }).disposed(by: disposeBag)
    }
}
