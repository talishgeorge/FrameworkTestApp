//
//  BaseViewController.swift
//  Airports
//
//  Created by Talish George on 06/08/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import UIKit
import CNavBarLib

class BaseViewController: UIViewController {
    public var navBar = CustomNavigationController.loadNavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navBar)
        let safeGuide = self.view.safeAreaLayoutGuide
        navBar.setupSafeAreaGuide(guide: safeGuide)
        setNavBarProperties()
        navBar.configureNavigationBar()
    }
    
    fileprivate func setNavBarProperties() {
        NavBarConstants.barBGColor = UIColor.init(hexString: "#0074b1", alpha: 1.0)
        NavBarConstants.transparentBGColor = UIColor.black.withAlphaComponent(0.5)
        NavBarConstants.leftNavButtonImage = UIImage(named: "back-navigation")!
        NavBarConstants.rightNavButtonImage = UIImage(named: "menu")!
        NavBarConstants.titleColor = UIColor.init(hexString: "#F3F3F3", alpha: 1.0)
        NavBarConstants.transparentTitleColor = UIColor.init(hexString: "#F3F3F3", alpha: 1.0)
        NavBarConstants.titleFont = UIFont.boldSystemFont(ofSize: 26)
        NavBarConstants.leftTitleText = ""
        NavBarConstants.rightTitleText = ""
        NavBarConstants.heightForLinearBar = 4
        NavBarConstants.backgroundProgressBarColor = UIColor.black
        NavBarConstants.progressBarColor = UIColor.white
        NavBarConstants.animaitonType = .fill
    }
}

