//
//  SubContentController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/3/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import SwiftyJSON

class SubContentController: AppController {
    typealias ContentCompletion = (_ succes : Bool,_ data : [SubContentModel]?) -> ()
    typealias TextCompletion = (_ status: Bool, _ data: String) -> ()
    var meetingService = MeetingService()
    var contents : [SubContentModel] = []
    func getMeeting(meetingId: Int) {
        meetingService.getOneMeeting(meetingId: meetingId).subscribe(onNext: {[weak self] data in
            guard let this = self else { return }
            this.contents = data.filter { $0.isFull == 1 }
            this.notifyObservers(.SubContent_gotData)
            }, onError: {[weak self] (error) in
                guard let this = self else { return }
                print(error)
                this.notifyObservers(.C_ShowError)
        }).disposed(by: disposeBag)
    }
    
    func parseTextToObjects(textName: String, _ completion: ContentCompletion) {
        var result:[SubContentModel] = []
        let path = Bundle.main.path(forResource: textName, ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [[String: Any]]
            for item in json {
               let subContentModel = SubContentModel(json: JSON(item))
                result.append(subContentModel)
            }
            
        } catch let error {
            print("parse error: \(error.localizedDescription)")
            completion(false, result)
        }
        
        completion(true, result)
    }
    
    func readTextFromFile(textName: String, _ completion: TextCompletion) {
        var result: String = ""
        let path = Bundle.main.path(forResource: textName, ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        result = String(data: data!, encoding: String.Encoding.utf8) ?? ""
        completion(true, result)
    }
    
    func pushTextToSystem(contents: [SubContentModel], meetingId: Int) {
        meetingService.mergeContentToSystem(contens: contents, meetingId: meetingId).subscribe(onNext: { [weak self] subcontents in
            guard let this = self else { return }
//            this.getMeeting(meetingId: meetingId)
            this.notifyObservers(.Preview_PushTextSuccess)
            }, onError: { [weak self] error in
                guard let this = self else { return }
                this.notifyObservers(.C_ShowError, data: error)
        }).disposed(by: disposeBag)
    }
    
    func updateText(meetingId: Int, index: Int) {
        meetingService.updateContent(content: contents[index], meetingId: meetingId, subcontentId: contents[index].subId).subscribe(onNext: { [weak self] subcontents in
            guard let this = self else { return }
            this.getMeeting(meetingId: meetingId)
            }, onError: { [weak self] error in
                guard let this = self else { return }
                this.notifyObservers(.C_ShowError, data: error)
        }).disposed(by: disposeBag)
    }
    
    func inviteUser(email: String, role: Int, meetingId: Int) {
        meetingService.inviteUser(email: email, role: role, meetingId: meetingId).subscribe(onNext: {[weak self] _ in
            guard let this = self else { return }
            this.notifyObservers(.SubContent_invited)
            }, onError: { (error) in
        }).disposed(by: disposeBag)
    }
}
