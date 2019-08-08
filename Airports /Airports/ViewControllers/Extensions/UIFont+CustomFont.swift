//
//  UIFont+Custom.swift
//  Airports
//
//  Created by Talish George on 6/12/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import Foundation
import UIKit
extension UIFont {
    class func customFont(fontName: String, size: CGFloat) -> UIFont {
        return UIFont(name: fontName, size: size)!
    }
}
