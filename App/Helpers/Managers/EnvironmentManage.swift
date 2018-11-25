//
//  EnvironmentManage.swift
//  JetFri
//
//  Created by Quan Nguyen Dinh on 9/12/18.
//  Copyright © 2018 UpPlus. All rights reserved.
//

import Foundation

protocol EnvironmentProtocol {
    var hostUrl: String { get }
    var socketUrl: String { get }
}

enum EnvType: Int {
    case Test
    case Product
}

class TestEnvironment: EnvironmentProtocol {
    var hostUrl: String {
        return "http://localhost:3000/api/"
    }
    
    var socketUrl: String {
        return "http://localhost:8080/"
    }
    
}

class ProductEnvironment: EnvironmentProtocol {
    var hostUrl: String {
        return "https://api.jetfri.com/"
    }
    
    var socketUrl: String {
        return "http://192.168.12.245:8080"
    }
    
}

class EnvironmentConfigure {
    private var enviroment: EnvironmentProtocol!
    
    init(type: EnvType) {
        switch type {
        case .Test:
            self.enviroment = TestEnvironment()
        case .Product:
            self.enviroment = ProductEnvironment()
        }
    }
    
    var hostUrl: String {
        return enviroment.hostUrl
    }
    
    var socketUrl: String {
        return enviroment.socketUrl
    }
    
}
