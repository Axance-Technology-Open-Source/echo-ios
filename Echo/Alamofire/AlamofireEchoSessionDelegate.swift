//
//  AlamofireEchoSessionDelegate.swift
//  Echo
//
//  Created by Charles Legrand on 20/02/2020.
//  Copyright © 2020 Axance Technology Open Source. All rights reserved.
//

import Alamofire

class AlamofireEchoSessionDelegate: SessionDelegate {
    
    override func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        let customData = Data("test 3".utf8)
        super.urlSession(session, dataTask: dataTask, didReceive: customData)
    }
}
