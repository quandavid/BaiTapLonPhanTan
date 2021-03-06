//
//  DQDefined.swift
//  DQ_User
//
//  Created by Gio Viet on 2/17/17.
//  Copyright © 2017 Paditech Inc. All rights reserved.
//

import UIKit

class FDefined: NSObject {
    //Config Environment
    #if DEBUG
        static let environment = EnvironmentConfigure(type: .Test)
    #else
        static let environment = EnvironmentConfigure(type: .Product)
    #endif
    
    //dev
    //must change release
    static let hostUrl : String = environment.hostUrl
    static let SocketUrl: String = environment.socketUrl
    static let appColor: UIColor = UIColor(red: 91/255, green: 52/255, blue: 255/255, alpha: 1)
    
}
