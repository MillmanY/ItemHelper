//
//  Define.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/20.
//

import UIKit
private var navigationItemHelperKey = "NavigationItemHelper+Key"
extension UINavigationItem {
    public var itemHelper: NavigationItemHelper {
        get {
            guard let att = objc_getAssociatedObject(self, &navigationItemHelperKey) as? NavigationItemHelper else {
                let a = NavigationItemHelper(self)
                objc_setAssociatedObject(self, &navigationItemHelperKey, a, .OBJC_ASSOCIATION_RETAIN)
                return a
            }
            return att
        }
    }
}

private var uiViewHelperKey = "uiViewHelper+Key"
extension UIView {
    public var viewHelper: UIViewHelper {
        get {
            guard let att = objc_getAssociatedObject(self, &uiViewHelperKey) as? UIViewHelper else {
                let a = UIViewHelper(self)
                objc_setAssociatedObject(self, &uiViewHelperKey, a, .OBJC_ASSOCIATION_RETAIN)
                return a
            }
            return att
        }
    }
}

private var uiImageHelperKey = "uiImageHelper+Key"
extension UIImage {
    public var imageHelper: ImageHelper {
        get {
            guard let att = objc_getAssociatedObject(self, &uiImageHelperKey) as? ImageHelper else {
                let a = ImageHelper(self)
                objc_setAssociatedObject(self, &uiImageHelperKey, a, .OBJC_ASSOCIATION_RETAIN)
                return a
            }
            return att
        }
    }
}

private var uiLabelHelperKey = "uiLabelHelper+Key"
extension UILabel {
    public var labelHelper: LabelHelper {
        get {
            guard let att = objc_getAssociatedObject(self, &uiLabelHelperKey) as? LabelHelper else {
                let a = LabelHelper(self)
                objc_setAssociatedObject(self, &uiLabelHelperKey, a, .OBJC_ASSOCIATION_RETAIN)
                return a
            }
            return att
        }
    }
}

