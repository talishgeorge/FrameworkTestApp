//
//  EndPointType.swift
//  Airports
//
//  Created by Talish George on 6/7/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL {
        get
    }
    var path: String {
        get
    }
    var httpMethod: HTTPMethod {
        get
    }
    var task: HTTPTask {
        get
    }
    var headers: HTTPHeaders? {
        get
    }
}
