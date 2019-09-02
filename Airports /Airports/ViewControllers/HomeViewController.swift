//
//  ViewController.swift
//  Airports
//  Created by Talish George on 6/4/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import UIKit
import CNavBarLib

class HomeViewController: UIViewController {
    
    var barBackgroundColor: UIColor = UIColor.blue.withAlphaComponent(0.5)
    var backText: String? = "<-- Go back uuu"
    
    //MARK: Private Properties
    private var leftBarButtonTitle: String
    private var rightBarButtonTitle: String
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
        
        //NavBarConstants.leftNavButtonImage = UIImage()
        //navBar.configureNavigationBar()
        
        // navBar.onRightButtonAction = { success in
        // self.performSegue(withIdentifier: "detailViewSegue", sender: self)
        //}
        NavBarConstants.rootNavigationController = self.navigationController
        NavBarConstants.barBGColor = UIColor.init(hexString: "#0074b1", alpha: 1.0)
        NavBarConstants.titleColor = UIColor.white
        NavBarConstants.titleText = "Hiiiiaidfiasdfisdafisadf"
        NavBarConstants.leftNavButtonImage = UIImage(named: "arrow")!
        NavBarConstants.leftTitleText = "<-Back"
        
        NavBarConstants.rightNavButtonImage = UIImage(named: "menu")!
        NavBarConstants.rightTitleText = "Right->"
        NavBarConstants.titleText = "Home"
        
        CustomNavigationBar.shared.onLeftButtonAction = { success in
            print("Left Bar Button Tapped")
        }
        CustomNavigationBar.shared.onRightButtonAction = { success in
            print("Right Bar Button Tapped")
        }
        CustomNavigationBar.shared.updateNavigation()
        //CustomNavigationBar.shared.applyTransparentBackgroundToTheNavigationBar(0.5)
        //CustomNavigationBar.shared.startHorizontalProgressbar()
        //CustomNavigationBar.shared.enableLargeTitleDisplayMode(UIColor.init(hexString: "#0074b1", alpha: 1.0))
        //UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(hexString: "#0074b1", alpha: 1.0)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
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
            //self.navBar.hideProgressBar()
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
        //setUpNavigation()
        searchBar.returnKeyType = UIReturnKeyType.done
        //self.navBar.startHorizontalProgressbar()
        //NavBarConstants.titleText = "Home"
        //navBar.configureNavigationBar()
        downloadAirportList()
    }
}
