//
//  SessionDelegateCustom.swift
//  ReplayExample
//
//  Created by Charles Legrand on 03/03/2020.
//  Copyright © 2020 Charles Legrand. All rights reserved.
//

import Alamofire

class SessionDelegateCustom: SessionDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print("didCompleteWithError")
        
        completionHandler(.allow)
    }
    
    override func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("didCompleteWithError")
//        super.urlSession(session, task: task, didCompleteWithError: error)
        let customData = Data("test 3".utf8)
        
        super.urlSession(session, dataTask: task as! URLSessionDataTask, didReceive: customData)
    }
    
    override func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        let customData = Data("test 3".utf8)
        super.urlSession(session, dataTask: dataTask, didReceive: customData)
    }
    
    
}
