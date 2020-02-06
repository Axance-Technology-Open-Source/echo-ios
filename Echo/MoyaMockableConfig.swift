//
//  MoyaMockableConfig.swift
//  Echo
//
//  Created by Charles Legrand on 01/02/2019.
//  Copyright © 2020-present Axance Technology. All rights reserved.
//

import Foundation
import Moya

public enum MoyaMockableConfigType {
    case recording
    case mockResponse
    case none
}

open class MoyaMockableConfig {
    open class func getMockableConfiguration(bundle: String? = nil, type: MoyaMockableConfigType)  -> PluginType {
        switch type {
        case .recording:
            return ScrapingNetworkInterceptor(bundle: bundle)
        case .mockResponse:
            return MockNetworkInterceptor(bundle: bundle)
        case .none:
            return EmptyPlugin()
        }
    }
}

class EmptyPlugin: PluginType {
    init() {}
}
