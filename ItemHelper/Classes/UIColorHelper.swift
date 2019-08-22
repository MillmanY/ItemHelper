//
//  UIColorHelper.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/22.
//

import Foundation
extension UIColor {
    /**
        ItemHelper Extension
        ```
        Set color to image
        ```
        */
    public func pixelImage() -> UIImage {
        let rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        self.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
