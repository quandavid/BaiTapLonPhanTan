//
//  SocketManager.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/24/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import Foundation
import SocketIO
import UIKit

class SocketIOManager {
    static let sharedInstance = SocketIOManager()
    var socketIOClient: SocketIOClient!
}
