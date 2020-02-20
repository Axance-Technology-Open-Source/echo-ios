//
//  ReplayInterceptor.swift
//  Echo
//
//  Created by Charles Legrand on 01/02/2019.
//  Copyright © 2020-present Axance Technology. All rights reserved.
//

import Foundation
import Moya

class ReplayInterceptor: PluginType {
    
    private var request: URLRequest?
    
    public func willSend(_ request: RequestType, target: TargetType) {
        self.request = request.request
    }
    
    public func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError> {
        guard let request = request, let data = EchoCore.replay(request: request) else {
            return result
        }
        
        let processedResponse = Response(statusCode: 200, data: data, request: request, response: nil)
        return .success(processedResponse)
    }
}
