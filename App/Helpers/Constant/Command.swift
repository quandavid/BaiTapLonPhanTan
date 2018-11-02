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
    
    //MARK: Meeting page
    Meeting_getAllSucess,
    
    //MARK: SubContent page
    SubContent_getDataSucess,
    //MARK: Home page
    Home_GotData
}
