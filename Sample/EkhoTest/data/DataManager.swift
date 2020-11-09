//
//  DataManager.swift
//  EkhoTest
//
//  Created by Charles Legrand on 03/03/2020.
//  Copyright © 2020 Charles Legrand. All rights reserved.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private let networkProvider: NetworkProviderProtocol
    
    init() {        
        networkProvider = NetworkMoyaProvider()
//        networkProvider = NetworkAlamofireProvider()
    }
    
    func getProfile(success: ((String) -> Void)?) {
        networkProvider.getProfile(success: success)
    }
}
