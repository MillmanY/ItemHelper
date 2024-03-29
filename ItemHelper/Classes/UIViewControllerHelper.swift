//
//  UIViewControllerHelper.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/21.
//

import Foundation
import UIKit
extension UIViewController {
    private static func findBestViewController(_ vc:UIViewController) -> UIViewController! {
        if((vc.presentedViewController) != nil) {
            return UIViewController.findBestViewController(vc.presentedViewController!)
        }
            
        else if(vc.isKind(of: UISplitViewController.classForCoder())){
            let splite = vc as! UISplitViewController
            if(splite.viewControllers.count > 0){
                return UIViewController.findBestViewController(splite.viewControllers.last!)
            }
                
            else{
                return vc
            }
        }
            
        else if(vc.isKind(of:UINavigationController.classForCoder())){
            let svc = vc as! UINavigationController
            if(svc.viewControllers.count > 0){
                return UIViewController.findBestViewController(svc.topViewController!)
            }
            else{
                return vc
            }
        }
            
        else if(vc.isKind(of:UITabBarController.classForCoder())){
            if let svc = vc as? UITabBarController,let v = svc.viewControllers , v.count > 0{
                return UIViewController.findBestViewController(svc.selectedViewController!)
                
            } else{
                return vc
            }
        }
            
        else{
            return vc
        }
    }
    
    
    /**
        ItemHelper Extension
        ```
        Find current ViewController on window
        ```
        */
    static public var current: UIViewController {
        get {
            let vc:UIViewController! = UIApplication.shared.keyWindow?.rootViewController
            return UIViewController.findBestViewController(vc)
        }
    }
}
