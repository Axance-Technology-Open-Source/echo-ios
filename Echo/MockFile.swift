//
//  MockFileGenerator.swift
//  Echo
//
//  Created by Charles Legrand on 19/02/2020.
//  Copyright © 2020 Axance Technology Open Source. All rights reserved.
//

import Foundation

extension URLRequest {
    
    func internalURL() throws -> URL {
        let fileName = try mockFileName()
        let internalScenarioDir = Utils.internalScenarioDir
        
        try? FileManager.default.createDirectory(at: internalScenarioDir, withIntermediateDirectories: true)
        
        return internalScenarioDir.appendingPathComponent(fileName)
    }
    
    func data() -> Data? {
        var mockFileUrl = try? assetURL()
        if mockFileUrl == nil {
            mockFileUrl = try? internalURL()
        }
        
        guard let fileUrl = mockFileUrl else {
            return nil
        }
        
        print("Echo: read mock json file from \(fileUrl.path)")
        
        return try? Data(contentsOf: fileUrl)
    }
    
    // MARK: Privates
    
    private func assetURL() throws -> URL {
        let fileName = try mockFileName()
        
        guard let mockBundlePath = Bundle.main.path(forResource: Utils.mockDirName, ofType: "bundle"),
            let mockBundle = Bundle(path: mockBundlePath),
            let path = mockBundle.path(forResource: fileName, ofType: "", inDirectory: EchoConfig.shared.scenario) else {
                throw MockFileError.bundleNotFound
        }
        
        return URL(fileURLWithPath: path)
    }
    
    private func mockFileName() throws -> String {
        guard let pathComponents = url?.pathComponents, let httpMethod = self.httpMethod else {
            throw MockFileError.unreadable
        }
            
        return MockFile.generateFileName(pathComponents: pathComponents, httpMethod: httpMethod)
    }
    
    enum MockFileError: Error {
        case unreadable
        case bundleNotFound
    }
}

private enum MockFile {
    
    static func generateFileName(pathComponents: [String], httpMethod: String) -> String {
        var pathComponents = pathComponents
        pathComponents.remove(at: 0)
        
        var fileName = httpMethod.uppercased()
        fileName += "-"
        fileName += pathComponents.joined(separator: "-")
        fileName += ".json"
        return fileName
    }
}
