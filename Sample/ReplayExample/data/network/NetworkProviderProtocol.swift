//
//  NetworkProtocol.swift
//  ReplayExample
//
//  Created by Charles Legrand on 03/03/2020.
//  Copyright © 2020 Charles Legrand. All rights reserved.
//

import Foundation

protocol NetworkProviderProtocol {
    
    func getProfile(success: ((String) -> Void)?)
}
