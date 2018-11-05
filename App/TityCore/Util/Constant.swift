//
//  Constant.swift
//  SotatekCore
//
//  Created by Thanh Tran on 9/19/16.
//  Copyright © 2016 SotaTek. All rights reserved.
//

import Foundation
import UIKit

class Constant {
    class RepositoryParam {
        static let requestParams = "request_params"
        static let requestHeader = "request_header"
    }

    class RequestParam {
        class Pagination {
              static let limit = "p_limit"
        }
    }

}

// Some Constant
public let SCREEN_WIDTH = UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
public let OS_VERSION = UIDevice.current.systemVersion

//UserDefault
public let standardUserDefaults = UserDefaults.standard
public let kUserInfo = "kUserInfo"
public let kAccessToken = "kAccessToken"
