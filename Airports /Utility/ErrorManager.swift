//
//  ErrorManager.swift
//  Airports
//
//  Created by Talish George on 6/13/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import Foundation
import UIKit

class ErrorManager {
    
    func getErrorMessage(errorType: Constants.MessageType) -> String {
        let message: String
        
        switch errorType {
        case .NetWork:
            message = errorType.description
        case .UnHandled:
            message = errorType.description
        }
        
        return message
    }
}
