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
        if case .success(let response) = result,
           let body = String(data: response.data, encoding: .utf8),
           let mockFileName = response.request?.mockFileName {
            
            let mockFileURL = mockFileName.mockFileUrl
            do {
                try body.write(to: mockFileURL, atomically: true, encoding: .utf8)
                print("Echo: write mock json file to \(mockFileURL.path)")
            } catch {
                print("Echo: failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding")
            }
        }
    }
}
