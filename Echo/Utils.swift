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
    
    static func getInternalAppMockFile(_ request: URLRequest, bundle: String? = nil) -> URL? {
        if let fileName = getMockFileNameFromResponse(request) {
            var internalAppMockDir = getInternalAppMockDir()
            if let bundle = bundle {
                internalAppMockDir.appendPathComponent(bundle)
            }
            do {
                try FileManager.default.createDirectory(at: internalAppMockDir, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            return internalAppMockDir.appendingPathComponent(fileName)
        }
        return nil
    }
    
    static func getAssetAppMockFileData(_ request: URLRequest, bundle: String? = nil) -> Data? {
        do {
            if let fileName = getMockFileNameFromResponse(request),
                let mockBundlePath = Bundle.main.path(forResource: "mocks", ofType: "bundle"),
                let mockBundle = Bundle(path: mockBundlePath),
                let path = mockBundle.path(forResource: fileName, ofType: "", inDirectory: bundle) {
                    return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func getInternalAppMockDir() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("mocks")
    }
    
    static func getMockFileNameFromResponse(_ request: URLRequest) -> String? {
        if var pathComponents = request.url?.pathComponents,
            let httpMethod = request.httpMethod {
            
            pathComponents.remove(at: 0)
            
            var fileName = httpMethod.uppercased()
            fileName += "-"
            fileName += pathComponents.joined(separator: "-")
            fileName += ".json"
            return fileName
        }
        return nil
    }
}
