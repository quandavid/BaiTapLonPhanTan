//
//  MeetingService.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/3/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import RxSwift

class MeetingService: AppService {
    let meetingRequest = RequestFactory.meetingRequest
    func getAllMeetings() -> Observable<[MeetingModel]> {
        return self.meetingRequest.getMeetingList().flatMap{ (response: HttpResponse) -> Observable<[MeetingModel]> in
            let meetingList = response.data.arrayValue.map { MeetingModel(json: $0)}
            return Observable<[MeetingModel]>.create({ subscribe in
                subscribe.onNext(meetingList)
                subscribe.onCompleted()
                return Disposables.create()
            })
        }
    }
    
    func getOneMeeting(meetingId : Int) -> Observable<SubContent> {
        return self.meetingRequest.getOneMeeting(meetingId: meetingId).flatMap({ (response: HttpResponse) -> Observable<SubContent> in
            let subContent = SubContent(json: response.data)
            return Observable<SubContent>.create({ (subscribe) in
                subscribe.onNext(subContent)
                subscribe.onCompleted()
                return Disposables.create()
            })
        })
    }
}
