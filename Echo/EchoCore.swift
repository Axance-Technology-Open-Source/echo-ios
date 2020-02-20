//
//  EchoCore.swift
//  Echo
//
//  Created by Charles Legrand on 19/02/2020.
//  Copyright © 2020 Axance Technology Open Source. All rights reserved.
//

import Foundation

enum EchoCore {
    
    static func record(body: String, request: URLRequest) {
        do {
            let internalURL = try request.internalURL()
            try body.write(to: internalURL, atomically: true, encoding: .utf8)
            print("Echo: write mock json file to \(internalURL.path)")
        } catch {
            print("Echo: failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding")
        }
    }
    
    static func replay(request: URLRequest) -> Data? {
        return request.data()
    }
}
