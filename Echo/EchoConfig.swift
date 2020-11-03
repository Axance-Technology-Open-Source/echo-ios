//
//  EchoConfig.swift
//  Echo
//
//  Created by Charles Legrand on 19/02/2020.
//  Copyright © 2020 Axance Technology Open Source. All rights reserved.
//

import Moya

public class EchoConfig {
    
    var scenario: String?
    var type: EchoType = .none
    
    public static let shared = EchoConfig()
    
    public func setup(_ type: EchoType, scenario: String? = nil) {
        self.type = type
        self.scenario = scenario
    }
}

public enum EchoType {
    case none,
    record,
    replay
}
