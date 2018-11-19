//
//  MeetingController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/1/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation

class MeetingController: AppController {
    var meetingService = MeetingService()
    var meetingList: [MeetingModel] = []
    func getAllMeetings() {
        meetingService.getAllMeetings().subscribe(onNext: {[weak self] (meetings) in
            guard let this = self else { return }
            this.meetingList = meetings
            this.notifyObservers(.Meeting_getAllSucess)
            }, onError: {[weak self] (error) in
                guard let this = self else { return }
                print(error)
                this.notifyObservers(.C_ShowError)
        }, onCompleted: {
            
        }).disposed(by: disposeBag)
    }
    
    func createNewMeeting(titleName: String) {
        meetingService.createNewMeeting(titleName: titleName).subscribe(onNext: { [weak self] meeting in
            guard let this = self else { return }
            this.meetingList.append(meeting)
            this.notifyObservers(.Meeting_createdNewMeeting)
            }, onError: { [weak self] error in
                guard let this = self else { return }
                print(error)
                this.notifyObservers(.C_ShowError)
        }).disposed(by: disposeBag)
    }
    
}
