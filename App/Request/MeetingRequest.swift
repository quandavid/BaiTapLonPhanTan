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
        return self.getAll(url: "sub_contents/\(meetingId)?token=\(token)", options: params)
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
        var contentDict: [[String: Any]]!
        var params : [String: Any] = [:]
        var type = 0
        if contents.first?.content == "" {
            type = 0
            contentDict = contents.map { $0.convertToDictionaryLeakContent() }
        } else if contents.first?.author == "" {
            type = 1
            contentDict = contents.map { $0.convertToDictionaryLeakAuthor() }
        } else {
            type = 2
            contentDict = contents.map { $0.convertToDictionaryFull() }
        }
        params[Constant.RepositoryParam.requestParams] = ["content": contentDict, "type": type]
        return self.create(url: "sub_contents/\(meetingId)?token=\(token)", options: params)
    }
    
    func updateContent( content: SubContentModel, meetingId: Int, subcontentId: Int) -> Observable<HttpResponse> {
        let token = standardUserDefaults.string(forKey: kAccessToken)!
        var params : [String: Any] = [:]
        params[Constant.RepositoryParam.requestParams] = ["author": content.author, "content": content.content, "start_time": content.startTime, "end_time": content.endTime]
        return self.update(url: "sub_contents/\(meetingId)/\(subcontentId)?token=\(token)", options: params)
    }
}
