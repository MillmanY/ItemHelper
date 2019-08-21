//
//  UIViewBaseExtensionObject.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/20.
//

import UIKit
public protocol BaseExtendProtocol {
    func coverFrame(new: CGRect)
}


public class UIViewBaseExtendObject {
    lazy var cover: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    unowned let base: UIView
    var boundObserver: NSKeyValueObservation?
    init(_ base: UIView) {
        self.base = base
        self.base.insertSubview(cover, at: 0)
        self.cover.leftAnchor.constraint(equalTo: self.base.leftAnchor).isActive = true
        self.cover.rightAnchor.constraint(equalTo: self.base.rightAnchor).isActive = true
        self.cover.topAnchor.constraint(equalTo: self.base.topAnchor).isActive = true
        self.cover.bottomAnchor.constraint(equalTo: self.base.bottomAnchor).isActive = true
        self.addObserver()
    }
    
    private func addObserver() {
        boundObserver = cover.observe(\.bounds, options: [.new, .initial], changeHandler: { [weak self] (view, change) in
            (self as? BaseExtendProtocol)?.coverFrame(new: change.newValue ?? .zero)
        })
        cover.isUserInteractionEnabled = false
        cover.backgroundColor = UIColor.clear
    }
    
    deinit {
        boundObserver?.invalidate()
        boundObserver = nil
    }
}
