//
//  AirportEndPoint.swift
//  Airports
//
//  Created by Talish George on 6/7/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case uat
    case production
    case staging
}

public enum AirPortApi {
    case airportByID(airportID:Int)
    case newAirpots
}

extension AirPortApi: EndPointType {
    
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://gist.githubusercontent.com/tdreyno/4278655/raw/"
        case .uat: return "https://gist.githubusercontent.com/tdreyno/4278655/raw/"
        case .staging: return "https://gist.githubusercontent.com/tdreyno/4278655/raw/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .newAirpots:
            return "7b0762c09b519f40397e4c3e100b097d861f5588/airports.json"
            
        case .airportByID(let airportID):
            return "\(airportID)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newAirpots:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil)
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
