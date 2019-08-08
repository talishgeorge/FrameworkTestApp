//
//  NetworkMonitor.swift
//  Airports
//
//  Created by Talish George on 6/7/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import Foundation
import Network

enum NetworkResponse: String {
    case success
    case authenticationError = "Need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "Could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}

struct NetworkManager {
    static let environment: NetworkEnvironment = .production
    static let airportAPIKey = ""
    let router = Router<AirPortApi>()
    
    func getAirports(completion: @escaping (_ airports: [AirportModel]?, _ error: String?) -> Void) {
        
        router.request(.newAirpots) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: [])
                        guard let jsonArray = jsonData as? [[String: Any]] else {
                            return
                        }
                        var airPortArray = [AirportModel]()
                        let parser = AirportParser()
                        airPortArray = parser.parseAirportList(dataArray: jsonArray)
                        completion(airPortArray, nil)
                        
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
