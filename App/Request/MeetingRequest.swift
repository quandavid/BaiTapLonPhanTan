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
        return self.getAll(url: "")
    }
    
    func getOneMeeting(meetingId: Int) -> Observable<HttpResponse> {
        return self.getAll(url: "\(meetingId)")
    }
}
