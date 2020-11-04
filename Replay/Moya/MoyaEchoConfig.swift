//
//  MoyaMockableConfig.swift
//  Replay
//
//  Created by Charles Legrand on 01/02/2019.
//  Copyright © 2020-present Axance Technology. All rights reserved.
//

import Foundation
import Moya

public extension ReplayConfig {
    
    var plugin: PluginType {
        switch ReplayConfig.shared.type {
        case .record:
            return RecordInterceptor()
            
        case .replay:
            return ReplayInterceptor()
            
        case .none:
            return EmptyPlugin()
        }
    }
}

class EmptyPlugin: PluginType {
    init() {}
}
