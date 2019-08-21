//
//  NavigationHelper.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/19.
//

import Foundation
import UIKit
public class NavigationItemHelper {
    unowned let base: UINavigationItem
    fileprivate var blockAction = [UIButton: (()->Void)]()
    public init(_ base: UINavigationItem) {
        self.base = base
    }
    
    @objc fileprivate func clickAction(btn: UIButton) {
        blockAction[btn]?()
    }
    
    deinit {
        blockAction.removeAll()
    }
}

extension NavigationItemHelper {
    
    public func removeRightButtons() {
        self.base.rightBarButtonItems?.removeAll()
    }

    public func removeLeftButtons() {
        self.base.leftBarButtonItems?.removeAll()
    }

    public func setRight(title: String, tint: UIColor? = nil, font: UIFont? = nil, action: @escaping (()->Void)) {
        let btn = self.buttonWith(title: title, tint: tint, font: font)
        blockAction[btn] = action
        self.base.rightBarButtonItems = [UIBarButtonItem(customView: btn)]
    }
    
    public func setRight(image: UIImage, tint: UIColor? = nil,action: @escaping (()->Void)) {
        let btn = self.buttonWith(image: image, tint: tint)
        blockAction[btn] = action
        self.base.rightBarButtonItems = [UIBarButtonItem(customView: btn)]
    }
    
    public func setLeft(image: UIImage, tint: UIColor? = nil, action: @escaping (()->Void)) {
        let btn = self.buttonWith(image: image, tint: tint)
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -25, bottom: 0, right: 0)
        blockAction[btn] = action
        self.base.leftBarButtonItems = [UIBarButtonItem(customView: btn)]
    }
    
    public func setLeft(title: String, tint: UIColor? = nil, font: UIFont? = nil, action: @escaping (()->Void)) {
        let btn = self.buttonWith(title: title, tint: tint, font: font)
        blockAction[btn] = action
        self.base.leftBarButtonItems = [UIBarButtonItem(customView: btn)]
    }

    public func addRight(image: UIImage, tint: UIColor? = nil,action: @escaping (()->Void)) {
        let btn = self.buttonWith(image: image, tint: tint)
        blockAction[btn] = action
        if var i = self.base.rightBarButtonItems {
            i.append(UIBarButtonItem(customView: btn))
            self.base.rightBarButtonItems = i
        } else {
            self.base.rightBarButtonItems = [UIBarButtonItem(customView: btn)]
        }
    }
    
    public func addLeft(image: UIImage, tint: UIColor? = nil, action: @escaping (()->Void)) {
        let btn = self.buttonWith(image: image, tint: tint)
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -25, bottom: 0, right: 0)
        blockAction[btn] = action
        if var i = self.base.leftBarButtonItems {
            i.append(UIBarButtonItem(customView: btn))
            self.base.leftBarButtonItems = i
        } else {
            self.base.leftBarButtonItems = [UIBarButtonItem(customView: btn)]
        }
    }
    
    private func buttonWith(image: UIImage, tint: UIColor? = nil) -> UIButton {
        let btn = UIButton()
        btn.frame = CGRect.init(origin: .zero, size: CGSize.init(width: 44, height: 44))
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -25)
        btn.imageView?.tintColor = tint
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action: #selector(clickAction(btn:)), for: .touchUpInside)
        return btn
    }
    
    private func buttonWith(title: String, tint: UIColor? = nil, font: UIFont? = nil) -> UIButton {
        let btn = UIButton()
        if let f = font  {
            btn.titleLabel?.font = f
        }
        btn.frame = CGRect.init(origin: .zero, size: CGSize.init(width: 44, height: 44))
        btn.imageView?.tintColor = tint
        btn.setTitle(title, for: .normal)
        btn.addTarget(self, action: #selector(clickAction(btn:)), for: .touchUpInside)
        return btn
    }
}
