//
//  Command.swift
//  BaseCore
//
//  Created by Quan Nguyen Dinh on 12/27/17.
//  Copyright © 2017 Quan Nguyen Dinh. All rights reserved.
//

import Foundation

@objc public enum Command: Int {
    public typealias RawValue = Int
    case
    //MARK: Common
    C_ShowError,
    C_InternetNotWorking,
    
    //MARK: Login page
    Login_loginFail,
    Login_loginSuccess,
    
    //MARK: Register page
    
    Register_registerSuccess,
    Register_registerFail,
    
    //MARK: Meeting page
    Meeting_getAllSucess,
    Meeting_createdNewMeeting,
    
    //MARK: SubContent page
    SubContent_gotData,
    SubContent_invited,
    Preview_PushTextSuccess,
    //MARK: Home page
    Home_GotData,
    
    //MARK: History page
    History_GetSuccess,
    History_GetFailure
}
