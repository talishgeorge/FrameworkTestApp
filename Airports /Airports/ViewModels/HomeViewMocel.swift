//
//  File.swift
//  Airports
//
//  Created by Talish George on 6/8/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: class {
    func didFinishFetchingAirportList(airPortList: [AirportModel])
    func didStartFetchingAirportList()
    func didFinishFilerAirportList(airPortList: [AirportModel])
    func didFinishWithNetworkError()
}

class HomeViewModel {
    let navigationBarTitle: String
    let leftBarButtonTitle: String
    let rightBarButtonTitle: String
    let fontName: String
    private let databaseManager = DataBaseManager.shared
    private let networkManager = NetworkManager()
    private var itemArray = [AirportModel]()
    private var filteredArray = [AirportModel]()
    weak var homeViewModelDelegate: HomeViewModelDelegate?
    
    // MARK: - Initializer
    init(navTitle: String, leftBarButtonTitle: String, rightBarButtonTitle: String, fontName: String) {
        self.navigationBarTitle = navTitle
        self.leftBarButtonTitle = leftBarButtonTitle
        self.rightBarButtonTitle = rightBarButtonTitle
        self.fontName = fontName
    }
    
    // MARK: - Download Airport List
    func downloadAirportList() {
        // 
        self.homeViewModelDelegate?.didStartFetchingAirportList()
        networkManager.getAirports() { itemArray, error in
            
            if itemArray?.count == 0 || itemArray == nil || error != nil {
                self.homeViewModelDelegate?.didFinishWithNetworkError()
            } else {
                self.itemArray.removeAll()
                self.itemArray = itemArray!
            }
            
            DispatchQueue.main.async {
                if self.itemArray.count > 0 {
                    self.homeViewModelDelegate?.didFinishFetchingAirportList(airPortList: self.itemArray)
                }
            }
        }
        
    }
    
    // MARK: - Filter Content Based on Search Text
    func filterContentForSearchText(_ searchText: String) {
        filteredArray = itemArray.filter({( airport: AirportModel) -> Bool in
            return airport.name!.lowercased().contains(searchText.lowercased())
        })
        
        self.homeViewModelDelegate?.didFinishFilerAirportList(airPortList: filteredArray)
    }
}
