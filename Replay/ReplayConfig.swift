//
//  ReplayConfig.swift
//  Replay
//
//  Created by Charles Legrand on 19/02/2020.
//  Copyright © 2020 Axance Technology Open Source. All rights reserved.
//

import Moya

public class ReplayConfig {
    
    var scenario: String?
    var type: ReplayType = .none
    
    public static let shared = ReplayConfig()
    
    public func setup(_ type: ReplayType, scenario: String? = nil) {
        self.type = type
        self.scenario = scenario
    }
}

public enum ReplayType {
    case none,
    record,
    replay
}
