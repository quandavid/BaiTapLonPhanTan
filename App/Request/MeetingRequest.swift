//
//  MeetingRequest.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/3/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import RxSwift

class MeetingRequest: AppRequest {
    func getMeetingList() -> Observable<HttpResponse> {
        let token = standardUserDefaults.string(forKey: kAccessToken)!
        let params : [String: Any] = [:]
        return self.getAll(url: "meetings?token=\(token)", options: params)
    }
    
    func getOneMeeting(meetingId: Int) -> Observable<HttpResponse> {
        let token = standardUserDefaults.string(forKey: kAccessToken)!
        let params : [String: Any] = [:]
        return self.getAll(url: "text_processing/\(meetingId)?token=\(token)", options: params)
    }
    
    func createNewMeeting(titleName: String) -> Observable<HttpResponse> {
        let token = standardUserDefaults.string(forKey: kAccessToken)!
        var params : [String: Any] = [:]
        params[Constant.RepositoryParam.requestParams] = ["title": titleName]
        return self.create(url: "meetings?token=\(token)", options: params)
    }
    
    func inviteUser(email: String, role: Int, meetingId: Int) -> Observable<HttpResponse> {
        let token = standardUserDefaults.string(forKey: kAccessToken)!
        var params : [String: Any] = [:]
        params[Constant.RepositoryParam.requestParams] = ["email": email, "role": role]
        return self.create(url: "invite_meeting/\(meetingId)?token=\(token)", options: params)
    }
    
    func mergeTextToSystem( contents: [SubContentModel], meetingId: Int) -> Observable<HttpResponse> {
        let token = standardUserDefaults.string(forKey: kAccessToken)!
        var params : [String: Any] = [:]
        params[Constant.RepositoryParam.requestParams] = ["content": contents.map { $0.convertToDictionary() }]
        return self.create(url: "text_precessing/\(meetingId)?token=\(token)", options: params)
    }
    
    func updateContent( content: SubContentModel, meetingId: Int, subcontentId: Int) -> Observable<HttpResponse> {
        let token = standardUserDefaults.string(forKey: kAccessToken)!
        var params : [String: Any] = [:]
        params[Constant.RepositoryParam.requestParams] = ["author": content.author, "content": content.content, "start_time": content.startTime, "end_time": content.endTime]
        return self.update(url: "text_precessing/\(meetingId)/\(subcontentId)?token=\(token)", options: params)
    }
}
