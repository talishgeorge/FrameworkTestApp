//
//  DetailsViewController.swift
//  Airports
//
//  Created by Talish George on 6/5/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import UIKit
import CoreLocation
import CNavBarLib

class DetailsViewController: BaseViewController {
    
    @IBOutlet weak var nearstAirportsTableView: UITableView!
    @IBOutlet weak var formattedAddress: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var detailsObj: AirportModel
    var airportArray = [AirportModel]()
    private var nearestAirportArray = [AirportModel]()
    private var nearestLocaitonArray = [CLLocation]()
    private var navTitle: String = ""
    private var fontName: String = ""
    private var leftBarButtonTitle: String = ""
    
    // MARK: - Observer Properties
    var viewModel: DetailViewModel! {
        didSet {
            self.navTitle = viewModel.navigationBarTitle
            self.fontName = viewModel.fontName
        }
    }
    
    // MARK: - View Management
    override func viewDidLoad() {
        super.viewDidLoad()
        nearstAirportsTableView.delegate = self
        nearstAirportsTableView.dataSource = self
        viewModel.detailViewModelDelegate = self
        configureView()
        navBar.onLeftButtonAction = { success in
            self.navBar.navigationController()?.popViewController(animated: true)
        }
        NavBarConstants.titleText = "Details"
        NavBarConstants.leftTitleText = "Back"
        NavBarConstants.leftRightTitleFont = UIFont.boldSystemFont(ofSize: 16)
        NavBarConstants.rightNavButtonImage = UIImage()
        navBar.configureNavBar()
        
        navBar.isHidden = false
    }
    
    // MARK: - Initilizer
    required init?(coder aDecoder: NSCoder) {
        self.detailsObj = AirportModel()
        super.init(coder: aDecoder)
    }
}

extension DetailsViewController: DetailViewModelDelegate {
    
    func didFinishWithNoData() {
        self.nearstAirportsTableView.isHidden = true
        showError(errorMessage: "No Records Found", title: "Airport", buttonTitle: "OK")
    }
    
    func didStartFilteringAirportList() {
        ActivityIndicator.show("Please Wait...")
    }
    
    func didFinishFilteringAirportList(airPortList: [AirportModel]) {
        self.nearestAirportArray = airPortList
        
        DispatchQueue.main.async {
            self.nearstAirportsTableView.reloadData()
        }
    }
}

// MARK: - Table View Data Source
extension DetailsViewController: UITableViewDataSource {
    // MARK: - Tableview Datasource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearestAirportArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureAirportCell(tableView, indexPath)
    }
}

// MARK: - Table View Delegate
extension DetailsViewController: UITableViewDelegate {
    // MARK: - Tableview Delegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
}

extension DetailsViewController {
    private func configureView() {
        viewModel.detailsObj = detailsObj
        viewModel?.airportArray = airportArray
        viewModel?.nearestAirportArray = nearestAirportArray
        viewModel.filterNearestAirports()
        self.navigationItem.title = self.navTitle
        self.nearstAirportsTableView.isHidden = false
    }
    
    private func configureAirportCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NearestAirportCell",
                                                 for: indexPath) as? NearestAirportCell
        
        var  airport = AirportModel()
        airport = nearestAirportArray[indexPath.row]
        cell?.cityLabel.text = airport.city
        cell?.countryLabel.text = airport.country
        cell?.runwaylabel.text = airport.runwaylength != "" ? airport.runwaylength : "----"
        cell?.indexLabel.text = String(indexPath.row + 1)
        
        return cell!
    }
    
    private func showError(errorMessage: String, title: String, buttonTitle: String) {
        let alertController = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        // Add the actions
        alertController.addAction(okAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
}

