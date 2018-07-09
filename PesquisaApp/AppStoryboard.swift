//
//  AppStoryboard.swift
//  Chu Ko Nu
//
//  Created by Kelvin Lima on 05/10/17.
//  Copyright © 2017 Wololo. All rights reserved.
//

import UIKit

/// Used to describe all storyboards identifiers.
/// Each case has the exactly name of storyboard.
///REF: https://medium.com/@gurdeep060289/clean-code-for-multiple-storyboards-c64eb679dbf6#.v24y54626
enum AppStoryboard: String
{
    case Main
    
    /// Returns istance of given storyboard
    var instance: UIStoryboard
    {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    //swiftlint:disable force_cast
    /// Instantiate a given view controller by its class.
    ///
    /// - Parameter viewControllerClass: Class of view controller to be instantiated.
    /// - Returns: View Controller instance.
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T
    {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
}

//Using class var instead of static propertie because static variable cannot be override by subclasses
extension UIViewController
{
    class var storyboardID: String
    {
        return "\(self)" + "_ID"
    }
    
    static func instantiate(appStoryboard: AppStoryboard) -> Self
    {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
