//
//  MockNetworkInterceptor.swift
//  Echo
//
//  Created by Charles Legrand on 01/02/2019.
//  Copyright © 2020-present Axance Technology. All rights reserved.
//

import Foundation
import Moya

open class MockNetworkInterceptor: PluginType {
    
    var bundle: String? = nil
    private var request: URLRequest?
    public init(bundle: String? = nil) {
        self.bundle = bundle
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {
        self.request = request.request
    }
    
    public func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError> {
        
        if let request = request {
            if case .success(let response) = result {
                return self.getMockedResponse(request: request, response: response.response) ?? result
            } else {
                return self.getMockedResponse(request: request, response: nil) ?? result
            }
        }
        return result
    }
    
    private func getMockedResponse(request: URLRequest, response: HTTPURLResponse?) -> Result<Moya.Response, MoyaError>? {
        
        if let fileData = Utils.getAssetAppMockFileData(request, bundle: bundle) {
            print("read mock json file of asset")
            let processedResponse = Response(statusCode: 200, data: fileData, request: request, response: response)
            return .success(processedResponse)
        } else{
            do {
                if let fileURL = Utils.getInternalAppMockFile(request, bundle: bundle) {
                    let fileContent = try Data(contentsOf: fileURL)
                    print("read mock json file at \(fileURL.path)")
                    let processedResponse = Response(statusCode: 200, data: fileContent, request: request, response: response)
                    return .success(processedResponse)
                }
            } catch {
                print("failed to read mock file")
            }
        }
        return nil
    }
}
