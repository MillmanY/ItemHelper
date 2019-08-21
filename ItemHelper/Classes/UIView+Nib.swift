//
//  UIView+Nib.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/20.
//

import UIKit
extension UIView {
    static private func instantiateFromNib<T: UIView>(viewType: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)!.first as! T
    }
    
    public class func loadNib() -> Self {
        return instantiateFromNib(viewType: self)
    }
    
    public func bindNibWithOwner() {
        let bundle = Bundle(for: self.classForCoder)
        let nib = UINib(nibName: String(describing: self.classForCoder), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": view]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": view]))
    }
}

