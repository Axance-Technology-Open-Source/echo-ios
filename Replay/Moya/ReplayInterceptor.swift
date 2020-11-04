//
//  ReplayInterceptor.swift
//  Replay
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
        guard let request = request, let mockData = request.mockFileData else {
            return result
        }
        
        let processedResponse = Response(statusCode: 200, data: mockData, request: request, response: nil)
        return .success(processedResponse)
    }
}

private extension URLRequest {
    
    var mockFileData: Data? {
        let mockFileUrl = mockFileName?.bundleMockFileURL != nil ?
            mockFileName?.bundleMockFileURL :
            mockFileName?.mockFileUrl
        
        guard let fileUrl = mockFileUrl else {
            return nil
        }
        
        print("Replay: read mock json file from \(fileUrl.path)")
        
        return try? Data(contentsOf: fileUrl)
    }
}
