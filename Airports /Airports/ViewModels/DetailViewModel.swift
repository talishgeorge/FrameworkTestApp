//
//  DetailViewModel.swift
//  Airports
//
//  Created by Talish George on 6/10/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import Foundation
import CoreLocation

protocol DetailViewModelDelegate: class {
    func didFinishFilteringAirportList(airPortList: [AirportModel])
    func didStartFilteringAirportList()
    func didFinishWithNoData()
}

protocol Container {
    associatedtype ItemType
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

class DetailViewModel {
    
    let navigationBarTitle: String
    let leftBarButtonTitle: String
    let fontName: String
    var detailsObj: AirportModel
    var airportArray = [AirportModel]()
    var nearestAirportArray = [AirportModel]()
    private var nearestLocaitonArray = [CLLocation]()
    private var locationManager: CLLocationManager!
    private var coord1 = CLLocation(latitude: 52.45678, longitude: 13.98765)
    private let coord2 = CLLocation(latitude: 52.12345, longitude: 13.54321)
    private let coord3 = CLLocation(latitude: 48.771896, longitude: 2.270748000000026)
    var lat: Double? = 0.00
    var lon: Double? = 0.00
    
    weak var detailViewModelDelegate: DetailViewModelDelegate?
    
    // MARK: - Initializer
    init(navTitle: String, leftBarButtonTitle: String, fontName: String) {
        self.navigationBarTitle = navTitle
        self.leftBarButtonTitle = leftBarButtonTitle
        self.fontName = fontName
        self.detailsObj = AirportModel()
    }
    
    // MARK: - Filter Nearest Airports
    func filterNearestAirports() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        lat =  Double(detailsObj.lat ?? "0.0")
        lon =  Double(detailsObj.lon ?? "0.0")
        
        let latitude: CLLocationDegrees = lat!
        let longitude: CLLocationDegrees = lon!
        var coordinates = [coord1, coord2]
        let userLocation: CLLocation  = CLLocation(latitude: latitude, longitude: longitude)
        coordinates.removeAll()
        
        buildCoordinates(&coordinates)
        nearestLocaitonArray.removeAll()
        extractNearestLocations(&coordinates, userLocation)
        appendNearestAirports()
        finishFilteringAirportList()
    }
    // Build Coordinates for finding the nearest airport
    private func buildCoordinates(_ coordinates: inout [CLLocation]) {
        for obj in  self.airportArray {
            lat =  Double(obj.lat ?? "")
            lon =  Double(obj.lon ?? "")
            
            coord1 = CLLocation(latitude: lat!, longitude: lon!)
            coordinates.append(coord1)
        }
    }
    
    private func extractNearestLocations(_ coordinates: inout [CLLocation], _ userLocation: CLLocation){
        for (_, _) in airportArray.enumerated() {
            let nearstLocation = closestLocation(locations: coordinates, closestToLocation: userLocation)
            
            var airportModel = AirportModel()
            airportModel.lat = String(format: "%f", nearstLocation?.coordinate.latitude ?? 0.0)
            airportModel.lon = String(format: "%f", nearstLocation?.coordinate.longitude ?? 0.0)
            nearestLocaitonArray.append(nearstLocation!)
            coordinates.firstIndex(of: nearstLocation!).map { coordinates.remove(at: $0) }
            
            if nearestLocaitonArray.count == 5 {
                break
            }
        }
    }
    private func appendNearestAirports() {
        for iDX in (0..<nearestLocaitonArray.count) {
            let latString = String(nearestLocaitonArray[iDX].coordinate.latitude)
            let longString = String(nearestLocaitonArray[iDX].coordinate.longitude)

            for jDX in (0..<airportArray.count) {
                let tmpLatString = String(airportArray[jDX].lat!)
                let tmpLongString = String(airportArray[jDX].lon!)

                if (tmpLatString == latString) && (tmpLongString == longString) {
                    nearestAirportArray.append(airportArray[jDX])
                }
            }
        }
        
    }
    
    private func finishFilteringAirportList() {
        DispatchQueue.main.async {
           // self.nearestAirportArray.removeAll()
            if self.nearestAirportArray.count > 0 {
                self.detailViewModelDelegate?.didFinishFilteringAirportList(airPortList: self.nearestAirportArray)
            }
            else {
                self.detailViewModelDelegate?.didFinishWithNoData()
            }
        }
    }
    
    // MARK: - Find the closet location
    func closestLocation(locations: [CLLocation], closestToLocation location: CLLocation) -> CLLocation? {
        if let closestLocation = locations.min(by: { location.distance(from: $0) < location.distance(from: $1) }) {
            return closestLocation
        } else {
            return nil
        }
    }
}
