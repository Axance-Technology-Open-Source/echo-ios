//
//  Utils.swift
//  Echo
//
//  Created by Charles Legrand on 01/02/2019.
//  Copyright © 2020-present Axance Technology. All rights reserved.
//

import Foundation
import Moya

class Utils {
    
    static let mockDirName = "mocks"
    
    static var internalScenarioDir: URL {
        var internalAppMockDir = Utils.internalAppMockDir
        if let scenario = EchoConfig.shared.scenario {
            internalAppMockDir.appendPathComponent(scenario)
        }
        return internalAppMockDir
    }
    
    private static var internalAppMockDir: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(mockDirName)
    }
    
    // return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    
}
