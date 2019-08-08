//
//  HomeViewController+TableView.swift
//  Airports
//
//  Created by Talish George on 6/12/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import Foundation
import UIKit

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
        let alpha = scrollView.contentOffset.y / -88
        //print("Scroll Offset =>", alpha)
        if alpha <= 0.2  {
            navBar.setTransparency(alpha: Float(abs(alpha)))
        }
        
        if (alpha <= 0) {
            navBar.setBGColorWithAlpha(alpha: 1.0)
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
