//
//  Utils.swift
//  Echo
//
//  Created by Charles Legrand on 01/02/2019.
//  Copyright © 2020-present Axance Technology. All rights reserved.
//

import Foundation

enum FileUtils {
    
    fileprivate static let mockDirName = "mocks"
    
    fileprivate static var appScenarioMockDirectory: URL {
        var appMockDirectory = FileUtils.appMockDirectory
        if let scenario = EchoConfig.shared.scenario {
            appMockDirectory.appendPathComponent(scenario)
        }
        return appMockDirectory
    }
    
    fileprivate static var appMockDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(mockDirName)
    }
    
}

extension String {
    
    var mockFileUrl: URL {
        let appScenarioMockDirectory = FileUtils.appScenarioMockDirectory
        
        try? FileManager.default.createDirectory(at: appScenarioMockDirectory, withIntermediateDirectories: true)
        
        return appScenarioMockDirectory.appendingPathComponent(self)
    }
    
    var bundleMockFileURL: URL? {
        guard let mockBundlePath = Bundle.main.path(forResource: FileUtils.mockDirName, ofType: "bundle"),
            let mockBundle = Bundle(path: mockBundlePath),
            let path = mockBundle.path(forResource: self, ofType: "", inDirectory: EchoConfig.shared.scenario) else {
                return nil
        }
        
        return URL(fileURLWithPath: path)
    }
}

extension URLRequest {
    
    var mockFileName: String? {
        guard let pathComponents = url?.pathComponents, let httpMethod = self.httpMethod else {
            return nil
        }
            
        return buildFileName(pathComponents: pathComponents, httpMethod: httpMethod)
    }
    
    private func buildFileName(pathComponents: [String], httpMethod: String) -> String {
        var pathComponents = pathComponents
        pathComponents.remove(at: 0)
        
        var fileName = httpMethod.uppercased()
        fileName += "-"
        fileName += pathComponents.joined(separator: "-")
        fileName += ".json"
        return fileName
    }
}
