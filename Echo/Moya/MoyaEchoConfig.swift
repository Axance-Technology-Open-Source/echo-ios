//
//  MoyaMockableConfig.swift
//  Echo
//
//  Created by Charles Legrand on 01/02/2019.
//  Copyright © 2020-present Axance Technology. All rights reserved.
//

import Foundation
import Moya

public extension EchoConfig {
    
    var plugin: PluginType {
        switch EchoConfig.shared.type {
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
