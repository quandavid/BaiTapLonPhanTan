//
//  SubContentController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/3/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation

class SubContentController: AppController {
    var meetingService = MeetingService()
    func getMeeting(meetingId: Int) {
        meetingService.getOneMeeting(meetingId: meetingId).subscribe(onNext: {[weak self] (data) in
            guard let this = self else { return }
            this.notifyObservers(.SubContent_getDataSucess, data: data)
            }, onError: {[weak self] (error) in
                guard let this = self else { return }
                print(error)
                this.notifyObservers(.C_ShowError)
        }).disposed(by: disposeBag)
    }
}
