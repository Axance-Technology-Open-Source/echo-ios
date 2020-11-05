//
//  NetworkMoya.swift
//  ReplayExample
//
//  Created by Charles Legrand on 03/03/2020.
//  Copyright © 2020 Charles Legrand. All rights reserved.
//

import Moya
import Replay

class NetworkMoyaProvider: NetworkProviderProtocol {
    
    let provider: MoyaProvider<NetworkMoyaService>
    
    init() {
        let authPlugin = AuthorizePlugin()
        authPlugin.accessToken = "12345"
        
        ReplayConfig.shared.setup(.replay)
        let replayPlugin = ReplayConfig.shared.plugin
        
        provider = MoyaProvider<NetworkMoyaService>(plugins: [authPlugin, replayPlugin])
    }
    
    func getProfile(replayMode: ReplayMode, success: ((String) -> Void)?) {
        switch replayMode {
        case .none:
            ReplayConfig.shared.setup(.none)
        case .record:
            ReplayConfig.shared.setup(.record)
        case .replay:
            ReplayConfig.shared.setup(.replay)
        }
        
        provider.request(.getProfile) { result in
            switch result {
            case .success(let response):
                if let responseString = try? response.mapString() {
                    success?(responseString)
                }
            case .failure(let error):
              print(error)
            }
        }
    }
}
