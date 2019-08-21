//
//  UIViewHelper.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/20.
//

import UIKit
public class UIViewHelper: UIViewBaseExtendObject, BaseExtendProtocol {
    private var isCircle = false
    var heightRate: CGFloat = 1.0
    
    lazy var gradient: CAGradientLayer = {
        let l = CAGradientLayer()
        cover.layer.insertSublayer(l, at: 0)
        return l
    }()
    
    lazy var lineLayer: DrawLineLayer = {
        let l = DrawLineLayer()
        l.fillColor = UIColor.clear.cgColor
        cover.layer.insertSublayer(l, at: 0)
        return l
    }()
    
    public func coverFrame(new: CGRect) {
        gradient.frame = CGRect(origin: new.origin, size: CGSize.init(width: new.width, height: new.height*heightRate))

        cover.superview?.bringSubviewToFront(cover)
        self.lineLayer.frame = new
        if let c = conerInfo {
            let path = UIBezierPath(roundedRect: self.base.bounds, byRoundingCorners: c.0, cornerRadii: CGSize(width: c.1, height: c.1))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.base.layer.mask = mask
        }
        if self.isCircle {
            base.layer.cornerRadius = min(new.size.width, new.size.height)/2
        }
    }
    
    var conerInfo: (UIRectCorner, CGFloat)?
}


// Draw
public extension UIViewHelper {
    
    func drawLine(direction: DrawLineLayer.Direction,
              color: UIColor = UIColor.lightGray,
              lineWidth: CGFloat = 1.0) {
        
        lineLayer.strokeColor = color.cgColor
        lineLayer.lineWidth = lineWidth
        lineLayer.direction = direction
    }
    
    func drawRadius(r: CGFloat) {
        base.layer.cornerRadius = r
        base.clipsToBounds = true
        self.isCircle = false
    }
    
    func drawShadow(radius: Float, opacity: Float = 0.5, offset: CGSize = CGSize(width: 0, height: 1)) {
        base.layer.shadowOffset  = offset
        base.layer.shadowColor   = UIColor.black.cgColor
        base.layer.shadowOpacity = opacity
        base.layer.shadowRadius  = CGFloat(radius)
        base.clipsToBounds = false
        isCircle = false
    }
    
    func drawCircle(width: CGFloat = 0, color: UIColor? = nil, needMaskBound: Bool = true) {
        self.isCircle = true
        base.layer.masksToBounds = needMaskBound
        base.layer.borderWidth = width
        if let borderColor = color {
            base.layer.borderColor  = borderColor.cgColor
        }
    }
    
    func drawBorder(width: CGFloat = 0, color: UIColor? = nil, radius: CGFloat, needMaskBound: Bool = true) {
        base.layer.cornerRadius = radius
        base.layer.masksToBounds = needMaskBound
        base.layer.borderWidth = width
        if let borderColor = color {
            base.layer.borderColor  = borderColor.cgColor
        }
        self.isCircle = false
    }
    
    func drawRoundCorners(_ corners: UIRectCorner?, radius: CGFloat = 5.0) {
        guard let c = corners else {
            self.conerInfo = nil
            self.base.layer.mask = nil
            return
        }
        self.conerInfo = (c, radius)
        self.base.layoutIfNeeded()
    }
}

extension UIViewHelper {
    public func gradient(colors: [UIColor]?) {
        gradient.colors = colors?.compactMap({ return $0.cgColor })
    }
    
    public func gradient(location: [NSNumber]?) {
        gradient.locations = location
    }
}
