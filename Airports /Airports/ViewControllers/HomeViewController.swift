//
//  ViewController.swift
//  Airports
//  Created by Talish George on 6/4/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import UIKit
import CNavBarLib

class HomeViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var overlayViewController: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainTableview: UITableView!
    var itemArray = [AirportModel]()
    var filteredArray = [AirportModel]()
    var errorManager = ErrorManager()
    var isSearching = false
    var selectedIndex = 0
    var error: NSString?
    var navTitle: String
    private var leftBarButtonTitle: String
    private var rightBarButtonTitle: String
    var fontName: String
    
    // MARK: - Observer Properties
    var viewModel: HomeViewModel! {
        didSet {
            self.navTitle = viewModel.navigationBarTitle
            self.leftBarButtonTitle = viewModel.leftBarButtonTitle
            self.rightBarButtonTitle = viewModel.rightBarButtonTitle
            self.fontName = viewModel.fontName
        }
    }
    
    // MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        self.navTitle = " "
        self.navTitle = " "
        self.leftBarButtonTitle = " "
        self.rightBarButtonTitle = " "
        self.fontName = " "
        super.init(coder: aDecoder)
    }
    
    // MARK: - Managing the View
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableview.dataSource = self
        mainTableview.delegate = self
        searchBar.delegate = self
        configureView()
        
        NavBarConstants.leftNavButtonImage = UIImage()
        navBar.configureNavBar()
        
        navBar.onRightButtonAction = { success in
            self.performSegue(withIdentifier: "detailViewSegue", sender: self)
        }
    }
    
    // MARK: - Download Airport List
    func downloadAirportList() {
        self.overlayViewController.isHidden = false
        viewModel.downloadAirportList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailViewSegue" {
            let detailsViewCotnroller = segue.destination as? DetailsViewController
            if isSearching {
                detailsViewCotnroller?.detailsObj = filteredArray[selectedIndex]
            } else {
                detailsViewCotnroller?.detailsObj = itemArray[selectedIndex]
            }
            
            detailsViewCotnroller?.airportArray = self.itemArray
            let viewModel = DetailViewModel(navTitle: "Details", leftBarButtonTitle: "Airports",
                                            fontName: "Georgia-Bold")
            detailsViewCotnroller?.viewModel = viewModel
        }
    }
}

extension HomeViewController: HomeViewModelDelegate {
    
    func didFinishWithNetworkError() {
        DispatchQueue.main.async {
            self.overlayViewController.isHidden = false
            ActivityIndicator.dismiss()
            
            self.showError(errorMessage:
                self.errorManager.getErrorMessage(errorType: Constants.MessageType.NetWork),
                           title: "Airports", buttonTitle: "Refresh")
        }
    }
    
    func didStartFetchingAirportList() {
        ActivityIndicator.show("Please Wait...")
    }
    
    func didFinishFetchingAirportList(airPortList: [AirportModel]) {
        self.itemArray.removeAll()
        self.itemArray = airPortList
        
        DispatchQueue.main.async {
            self.mainTableview.reloadData()
            ActivityIndicator.dismiss()
            self.navBar.hidePrgressBar()
        }
    }
    
    func didFinishFilerAirportList(airPortList: [AirportModel]) {
        self.filteredArray = airPortList
        mainTableview.reloadData()
    }
}

extension HomeViewController {
    private func showError(errorMessage: String, title: String, buttonTitle: String) {
        let alertController = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default) { _ in
            self.viewModel.downloadAirportList()
        }
        // Add the actions
        alertController.addAction(okAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func configureView() {
        overlayViewController.isHidden = false
        ActivityIndicator.spinnerStyle(.spinningFadeCircle)
        viewModel = HomeViewModel(navTitle: "Airports", leftBarButtonTitle: "Refresh",
                                  rightBarButtonTitle: "Settings", fontName: "Georgia-Bold")
        viewModel.homeViewModelDelegate = self
        itemArray.removeAll()
        //searchBar.isUserInteractionEnabled = false
        searchBar.alpha = 0.6
        setUpNavigation()
        searchBar.returnKeyType = UIReturnKeyType.done
        self.navBar.stratHorizontalProgressbar()
        NavBarConstants.titleText = "Home"
        navBar.configureNavBar()
        downloadAirportList()
    }
}
