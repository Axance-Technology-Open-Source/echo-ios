//
//  AccessTokenAdapter.swift
//  ReplayExample
//
//  Created by Charles Legrand on 19/02/2020.
//  Copyright © 2020 Charles Legrand. All rights reserved.
//

import Alamofire

class AccessTokenAdapter: RequestAdapter {
    private let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    // MARK: - RequestAdapter
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        urlRequest.setValue(accessToken, forHTTPHeaderField: "token")
        
        completion(.success(urlRequest))
    }
}
