//
//  AuthorizePlugin.swift
//  MobiMe
//
//  Created by Charles Legrand on 13/01/2020.
//  Copyright © 2019 transdev. All rights reserved.
//

import Moya

class AuthorizePlugin: PluginType {
    
    var accessToken: String? = ""
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        if let accessToken = self.accessToken {
            request.setValue("\(accessToken)", forHTTPHeaderField: "token")
        }
        return request
    }
}
