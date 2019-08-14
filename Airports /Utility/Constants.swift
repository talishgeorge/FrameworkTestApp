//
//  Constants.swift
//  Airports
//
//  Created by Talish George on 6/13/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import Foundation

class Constants {
    enum MessageType: String {
        case NetWork
        case UnHandled
        
        var description: String {
            switch self {
            case .NetWork:
                return "Internet Connection not Available!."
            case .UnHandled:
                return "Unhandled Exception!."
            }
        }
    }
    
    enum ApplicationError: Error {
        case Empty
        case NetworkError
        case UnHandledException
        case FatalError
    }
    
}


