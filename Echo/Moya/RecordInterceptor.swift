//
//  RecordInterceptor.swift
//  Echo
//
//  Created by Charles Legrand on 01/02/2019.
//  Copyright © 2020-present Axance Technology. All rights reserved.
//

import Foundation
import Moya

class RecordInterceptor: PluginType {
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        if case .success(let response) = result {
            if let body = String(data: response.data, encoding: .utf8), let responseRequest = response.request {
                EchoCore.record(body: body, request: responseRequest)
            }
        }
    }
}
