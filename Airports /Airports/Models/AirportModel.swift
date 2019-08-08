//
//  NearByPlaces.swift
//  Airports
//
//  Created by Talish George on 6/6/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import Foundation

struct AirportModel {
    var code: String?
    var lat: String?
    var lon: String?
    var name: String?
    var city: String?
    var state: String?
    var country: String?
    var woeid: String?
    var timezone: String?
    var phone: String?
    var type: String?
    var email: String?
    var url: String?
    var runwaylength: String?
    var elev: String?
    var icao: String?
    var directflights: String?
    var carriers: String?
}

extension AirportModel: Decodable {
    
    enum AirportCodingKeys: String, CodingKey {
        case code = "code_key"
        case lat = "lat_key"
        case lon = "lon_key"
        case name = "name_key"
        case city = "city_key"
        case state = "state_key"
        case country = "country_key"
        
        case woeid = "woeid_key"
        case timezone = "timezone_key"
        case phone = "phone_key"
        case type = "type_key"
        case email = "email_key"
        case url = "url_key"
        case runwaylength = "runwaylength_key"
        
        case elev = "elev_key"
        case icao = "icao_key"
        case directflights = "directflights_key"
        case carriers = "carriers_key"
    }
    
    init(from decoder: Decoder) throws {
        let airportContainer = try decoder.container(keyedBy: AirportCodingKeys.self)
        
        code = try airportContainer.decode(String.self, forKey: .code)
        lat = try airportContainer.decode(String.self, forKey: .lon)
        lon = try airportContainer.decode(String.self, forKey: .lon)
        name = try airportContainer.decode(String.self, forKey: .name)
        city = try airportContainer.decode(String.self, forKey: .city)
        state = try airportContainer.decode(String.self, forKey: .state)
        country = try airportContainer.decode(String.self, forKey: .country)
        
        woeid = try airportContainer.decode(String.self, forKey: .woeid)
        timezone = try airportContainer.decode(String.self, forKey: .timezone)
        phone = try airportContainer.decode(String.self, forKey: .phone)
        type = try airportContainer.decode(String.self, forKey: .type)
        email = try airportContainer.decode(String.self, forKey: .email)
        url = try airportContainer.decode(String.self, forKey: .url)
        runwaylength = try airportContainer.decode(String.self, forKey: .runwaylength)
        
        elev = try airportContainer.decode(String.self, forKey: .elev)
        icao = try airportContainer.decode(String.self, forKey: .icao)
        directflights = try airportContainer.decode(String.self, forKey: .directflights)
        carriers = try airportContainer.decode(String.self, forKey: .carriers)
    }
    
    static func == (lhs: AirportModel, rhs: AirportModel) -> Bool {
        var returnValue = false
        if (lhs.lat == rhs.lat) && (lhs.lon == rhs.lon)
        {
            returnValue = true
        }
        return returnValue
    }
}
