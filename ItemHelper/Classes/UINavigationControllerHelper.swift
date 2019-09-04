//
//  UINavigationControllerHelper.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/22.
//

import Foundation

extension UINavigationController {
    public func setBarClear() {
        self.setBarColor(color: .clear, isTranslucent: true)
    }
    
    public func setBarColor(color: UIColor, isTranslucent: Bool = true){
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(color.pixelImage(), for: .default)
        self.navigationBar.isTranslucent = isTranslucent
        self.navigationBar.barTintColor = UIColor.clear
    }
    
    public func setBarColorGradient(colors: [UIColor]) {
        self.navigationBar.shadowImage = UIImage()
        let height = UIApplication.shared.statusBarFrame.height + self.navigationBar.frame.height
        let frame = CGRect(x: 0, y: 0, width: self.navigationBar.frame.size.width, height: height)
        let image =  UIImage.gradient(frame: frame, colors: colors)
        self.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor.clear
    }
}
