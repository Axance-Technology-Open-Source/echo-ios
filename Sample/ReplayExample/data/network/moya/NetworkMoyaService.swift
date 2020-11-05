//
//  NetworkMoyaService.swift
//  ReplayExample
//
//  Created by Charles Legrand on 03/03/2020.
//  Copyright © 2020 Charles Legrand. All rights reserved.
//

import Moya

public enum NetworkMoyaService {
  // 1
  static private let publicKey = "YOUR PUBLIC KEY"
  static private let privateKey = "YOUR PRIVATE KEY"

  // 2
  case getProfile
}

extension NetworkMoyaService: TargetType {
  // 1
  public var baseURL: URL {
    return URL(string: "https://ddf-starter-main-api.herokuapp.com/")!
  }

  // 2
  public var path: String {
    switch self {
    case .getProfile: return "profile"
    }
  }

  // 3
  public var method: Moya.Method {
    switch self {
    case .getProfile: return .get
    }
  }

  // 4
  public var sampleData: Data {
    return Data()
  }

  // 5
  public var task: Task {
    return .requestPlain // TODO
  }

  // 6
  public var headers: [String: String]? {
    return ["Content-Type": "application/json"]
  }

  // 7
  public var validationType: ValidationType {
    return .successCodes
  }
}
