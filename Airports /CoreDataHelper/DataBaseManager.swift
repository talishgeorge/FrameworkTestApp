//
//  CoreDataHelper.swift
//  Airports
//
//  Created by Talish George on 6/6/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import Foundation
import CoreData

class DataBaseManager {
    
    //Singleton Instance
    public static let shared = DataBaseManager()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Helper Methods - Save Airport List
    private func saveContext() {
        do {
            try persistentContainer.viewContext.save()
        } catch _ {
            
        }
    }
    
    private func populateAirportModelDTO(_ dataArray: [AirportModel]) {
        for anAirport in dataArray {
            
            let airport = NSEntityDescription.insertNewObject(forEntityName: "Airport",
                                                              into: persistentContainer.viewContext)
                as? Airport
            
            airport?.code = anAirport.code ?? ""
            airport?.lat = anAirport.lat ?? ""
            airport?.lon = anAirport.lon ?? ""
            airport?.name = anAirport.name ?? ""
            airport?.city = anAirport.city ?? ""
            airport?.state = anAirport.state ?? ""
            airport?.country = anAirport.country ?? ""
            airport?.woeid = anAirport.woeid ?? ""
            airport?.tz = anAirport.timezone ?? ""
            airport?.phone = anAirport.phone ?? ""
            airport?.type = anAirport.type ?? ""
            airport?.email = anAirport.email ?? ""
            airport?.url = anAirport.url ?? ""
            airport?.runway_length = anAirport.runwaylength ?? ""
            airport?.elev = anAirport.elev ?? ""
            airport?.icao = anAirport.icao ?? ""
            airport?.direct_flights = anAirport.directflights ?? ""
            airport?.carriers = anAirport.carriers ?? ""
            
            saveContext()
        }
    }
    
    public func createAirportList(dataArray: [AirportModel]) {
        populateAirportModelDTO(dataArray)
    }
    
    // MARK: - Core Data Helper Methods - Fetch Airport List
    public func fetch() -> [Airport] {
        var airports = [Airport]()
        let fetchRequest = NSFetchRequest<Airport>(entityName: "Airport")
        
        do {
            airports = try persistentContainer.viewContext.fetch(fetchRequest)
        } catch _ {
            
        }
        return airports
    }
}
