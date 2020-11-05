//
//  NetworkAlamofire.swift
//  ReplayExample
//
//  Created by Charles Legrand on 03/03/2020.
//  Copyright © 2020 Charles Legrand. All rights reserved.
//

import Foundation
import Alamofire

class NetworkAlamofireProvider: NetworkProviderProtocol {
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        let accessTokenManager = AccessTokenAdapter(accessToken: "1234")
        let interceptors = Interceptor(adapters: [accessTokenManager], retriers: [])
        
        return Session(configuration: configuration,
//                       delegate: SessionDelegateCustom(),
                       interceptor: interceptors)
    }()
    
    func getProfile(replayMode: ReplayMode, success: ((String) -> Void)?) {
        session.request("https://ddf-starter-main-api.herokuapp.com/profile")
            .responseJSON { response in
                if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                    success?(responseString)
                }
            }
    }
    
    
}
