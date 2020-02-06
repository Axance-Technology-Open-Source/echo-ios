//
//  ScrapingNetworkInterceptor.swift
//  Echo
//
//  Created by Charles Legrand on 01/02/2019.
//  Copyright © 2020-present Axance Technology. All rights reserved.
//

import Foundation
import Moya

open class ScrapingNetworkInterceptor: PluginType {
    
    var bundle: String? = nil
    
    public init(bundle: String? = nil) {
        self.bundle = bundle
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        if case .success(let response) = result {
            if let body = parseResponse(response), let responseRequest = response.request, let fileURL = Utils.getInternalAppMockFile(responseRequest, bundle: bundle) {
                do {
                    try body.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                    print("write mock json file to \(fileURL.path)")
                } catch {
                    print("failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding")
                }
            }
        }
    }

    func parseResponse(_ response: Moya.Response) -> String? {
        return String(data: response.data, encoding: String.Encoding.utf8)
    }
}
