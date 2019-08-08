//
//  AirportParser.swift
//  Airports
//
//  Created by Talish George on 6/7/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import Foundation

class AirportParser {
    var itemArray = [AirportModel]()
    var airport = AirportModel()
    
    private func populateAirportModelSectionA(_ airport:  AirportModel, _ code: Any, _ lat: Any,
                                              _ lon: Any, _ name: Any) {
        self.airport.code = code as? String ?? ""
        self.airport.lat = lat as? String ?? ""
        self.airport.lon = lon as? String ?? ""
        self.airport.name = name as? String ?? ""
    }
    
    private func populateAirportModelSectionB(_ airport:  AirportModel, _ city: Any, _ state: Any,
                                              _ country: Any, _ woeid: Any) {
        self.airport.city = city as? String ?? ""
        self.airport.state = state as? String ?? ""
        self.airport.country = country as? String ?? ""
        self.airport.woeid = woeid as? String ?? ""
    }
    
    private func populateAirportModelSectionC(_ airport:  AirportModel, _ timezone: Any, _ phone: Any,
                                              _ type: Any, _ email: Any) {
        self.airport.timezone = timezone as? String ?? ""
        self.airport.phone = phone as? String ?? ""
        self.airport.type = type as? String ?? ""
        self.airport.email = email as? String ?? ""
    }
    
    private func populateAirportModelSectionD(_ airport:  AirportModel, _ url: Any, _ runwaylength: Any,
                                              _ elev: Any, _ icao: Any) {
        self.airport.url = url as? String ?? ""
        self.airport.runwaylength = runwaylength as? String ?? ""
        self.airport.elev = elev as? String ?? ""
        self.airport.icao = icao as? String ?? ""
    }
    
    private func populateAirportModelSectionE(_ airport:  AirportModel, _ directflights: Any,
                                              _ carriers: Any) {
        self.airport.directflights = directflights as? String ?? ""
        self.airport.carriers = carriers as? String ?? ""
    }
    
    func parseAirportList(dataArray: [[String: Any]]) -> [AirportModel] { 
        var index = 0
        for dic in dataArray {
            index += 1
            let code = dic["code"] ?? ""
            let lat = dic["lat"] ?? ""
            let lon = dic["lon"] ?? ""
            let name = dic["name"] ?? ""
            let city = dic["city"] ?? ""
            let state = dic["state"] ?? ""
            let country = dic["country"] ?? ""
            let woeid = dic["woeid"] ?? ""
            let timezone = dic["tz"] ?? ""
            let phone = dic["phone"] ?? ""
            let type = dic["type"] ?? ""
            let email = dic["email"] ?? ""
            let url = dic["url"] ?? ""
            let runwaylength = dic["runway_length"] ?? ""
            let elev = dic["elev"] ?? ""
            let icao = dic["icao"] ?? ""
            let directflights = dic["direct_flights"] ?? ""
            let carriers = dic["carriers"] ?? ""
            
            //var airport = AirportModel()
            populateAirportModelSectionA(airport, code, lat, lon, name)
            populateAirportModelSectionB(airport, city, state, country, woeid)
            populateAirportModelSectionC(airport, timezone, phone, type, email)
            populateAirportModelSectionD(airport, url, runwaylength, elev, icao)
            populateAirportModelSectionE(airport, directflights, carriers)
            itemArray.append(airport)
        }
        
        return itemArray
    }
}
