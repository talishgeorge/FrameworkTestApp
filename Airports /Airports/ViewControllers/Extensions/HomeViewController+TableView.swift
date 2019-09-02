//
//  HomeViewController+TableView.swift
//  Airports
//
//  Created by Talish George on 6/12/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import Foundation
import UIKit
import CNavBarLib

extension HomeViewController: UITableViewDataSource {
    // MARK: - Tableview Datasource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filteredArray.count
        }
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirportCell", for: indexPath)
        
        populateAirportCell(indexPath, cell)
        
        return cell
    }
    
    private func populateAirportCell(_ indexPath: IndexPath, _ cell: UITableViewCell) {
        var  airport = AirportModel()
        if isSearching {
            airport = filteredArray[indexPath.row]
        } else {
            airport = itemArray[indexPath.row]
        }
        
        cell.textLabel?.text = airport.name
        cell.detailTextLabel?.text = airport.city
        cell.accessoryType = .disclosureIndicator
        self.overlayViewController.isHidden = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 144
       
        if offset >= 0  {
            offset = 1
            let color =  UIColor(hexString: "#0074b1", alpha: Float(offset))

           CustomNavigationBar.shared.applyTransparentBackgroundToTheNavigationBar(offset,color)
           UIApplication.shared.statusBarView?.backgroundColor = color
           //CustomNavigationBar.shared.resetNavigation()
            
        }
        else {
            print(offset)
            if(abs(offset) > 0.3){
            offset = 0.3
            }
            let color = UIColor.black.withAlphaComponent(abs(offset))
           //CustomNavigationBar.shared.enableLargeTitleDisplayMode(UIColor.init(hexString: "#0074b1", alpha: 1.0))
            CustomNavigationBar.shared.applyTransparentBackgroundToTheNavigationBar(offset,color)
            UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
        }
    }
}

// MARK: - Table View Delegate
extension HomeViewController: UITableViewDelegate {
    // MARK: - Tableview Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedIndex =  indexPath.row
        self.performSegue(withIdentifier: "detailViewSegue", sender: self)
    }
}
