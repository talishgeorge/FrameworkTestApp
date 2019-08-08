//
//  File.swift
//  Airports
//
//  Created by Talish George on 6/13/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Search Bar View Delegate
extension HomeViewController: UISearchBarDelegate {
    
    // MARK: - SearchBar Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            self.searchBar.isUserInteractionEnabled = false
            self.searchBar.alpha = 0.6
            self.searchBar.text = ""
            mainTableview.reloadData()
        } else {
            isSearching = true
            self.searchBar.isUserInteractionEnabled = true
            self.searchBar.alpha = 1.0
            viewModel.filterContentForSearchText(searchBar.text!)
        }
    }
}
