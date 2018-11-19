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
    
    func getOneMeeting(meetingId : Int) -> Observable<[SubContentModel]> {
        return self.meetingRequest.getOneMeeting(meetingId: meetingId).flatMap({ (response: HttpResponse) -> Observable<[SubContentModel]> in
            let subContents = response.data.arrayValue.map { SubContentModel(json: $0)}
            return Observable<[SubContentModel]>.create({ (subscribe) -> Disposable in
                subscribe.onNext(subContents)
                subscribe.onCompleted()
                return Disposables.create()
            })
        })
    }
    
    func createNewMeeting(titleName: String) -> Observable<MeetingModel> {
        return self.meetingRequest.createNewMeeting(titleName: titleName).flatMap({ (response: HttpResponse) -> Observable<MeetingModel> in
            let newMeeting = MeetingModel(json: response.data)
            return Observable<MeetingModel>.create({ (subscribe) -> Disposable in
                subscribe.onNext(newMeeting)
                subscribe.onCompleted()
                return Disposables.create()
            })
        })
    }
    
    func inviteUser( email: String, role: Int, meetingId: Int) -> Observable<RoleModel> {
        return self.meetingRequest.inviteUser(email: email, role: role, meetingId: meetingId).flatMap({ (response: HttpResponse) -> Observable<RoleModel> in
            let roleModel = RoleModel(json: response.data)
            return Observable<RoleModel>.create({ (subscribe) -> Disposable in
                subscribe.onNext(roleModel)
                subscribe.onCompleted()
                return Disposables.create()
            })
        })
    }
    
    func mergeContentToSystem( contens: [SubContentModel], meetingId: Int) -> Observable<[SubContentModel]> {
        return self.meetingRequest.mergeTextToSystem(contents: contens, meetingId: meetingId).flatMap({ (response: HttpResponse) -> Observable<[SubContentModel]> in
            let subContents = response.data.arrayValue.map { SubContentModel(json: $0)}
            return Observable<[SubContentModel]>.create({ (subscribe) -> Disposable in
                subscribe.onNext(subContents)
                subscribe.onCompleted()
                return Disposables.create()
            })
           
        })
    }
    
    func updateContent( content: SubContentModel, meetingId: Int, subcontentId: Int) -> Observable<SubContentModel> {
        return self.meetingRequest.updateContent(content: content, meetingId: meetingId, subcontentId: subcontentId).flatMap({ (response: HttpResponse) -> Observable<SubContentModel> in
            let subContent = SubContentModel(json: response.data)
            return Observable<SubContentModel>.create({ (subscribe) -> Disposable in
                subscribe.onNext(subContent)
                subscribe.onCompleted()
                return Disposables.create()
            })
        })
    }
}
