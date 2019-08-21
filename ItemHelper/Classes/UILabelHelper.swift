//
//  UILabelHelper.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/21.
//
import Foundation
import UIKit
public struct UnderLineMarker {
    let value: String
    let color: UIColor
}

public typealias MutipleMarkerBLock = ((_ obj: UnderLineMarker)->Void)

public class LabelHelper {
    unowned let base: UILabel
    var clickMap = [NSRange: (block: MutipleMarkerBLock, marker: UnderLineMarker)]()
    var gesture: UITapGestureRecognizer?
    public init(_ base: UILabel) {
        self.base = base
    }
    
    @objc func handle(gesture: UITapGestureRecognizer) {
        let layoutManager = NSLayoutManager()
        let container = NSTextContainer(size: base.frame.size)
        let storage = NSTextStorage(string: base.text ?? "")
        
        container.size = base.bounds.size
        layoutManager.addTextContainer(container)
        storage.addLayoutManager(layoutManager)
        container.lineFragmentPadding = 0.0
        container.lineBreakMode = base.lineBreakMode
        container.maximumNumberOfLines = base.numberOfLines
        
        let location = gesture.location(in: gesture.view)
        let index = layoutManager.characterIndex(for: location, in: container, fractionOfDistanceBetweenInsertionPoints: nil)
        guard let _ = base.attributedText?.string.count else {
            return
        }
        self.clickMap.forEach({ (key,value) in
            if index >= key.location && index <= key.location+key.length {
                value.block(value.marker)
            }
        })
    }
}

extension LabelHelper  {
    @discardableResult
    public func set(attribute: String) -> Self {
        self.base.attributedText = NSAttributedString(string: attribute)
        return self
    }
    
    public func groupValue(_ attribute: [String: [NSAttributedString.Key: Any]]) {
        guard let attr = self.base.attributedText else {
            return
        }
        let mutable = NSMutableAttributedString(attributedString: attr)
        attribute.forEach { (key, value) in
            
            attr.string.subStrings(key).forEach({
                mutable.addAttributes(value, range: $0)
            })
        }
        self.base.attributedText = mutable
    }
    
    public func groupColor(map: [String: UIColor]) {
        map.forEach {
            self.subString($0.key, color: $0.value)
        }
    }
    
    public func subString(_ value: String, color: UIColor) {
        
        guard let attr = self.base.attributedText else {
            return
        }
        
        let mutable = NSMutableAttributedString.init(attributedString: attr)
        self.subStrings(value).forEach { (r) in
            mutable.addAttribute(.foregroundColor, value: color, range: r)
        }
        self.base.attributedText = mutable
    }
    
    func removeAllMarker() {
        self.clickMap.removeAll()
    }
    
    public func mutipleUnderLine(markers: [UnderLineMarker], click: @escaping MutipleMarkerBLock) {
        markers.forEach { (marker) in
            self.underLine(marker: marker, click: click)
        }
    }
    
    public func underLine(marker: UnderLineMarker, click: MutipleMarkerBLock? = nil) {
        guard let attr = self.base.attributedText else {
            return
        }
        
        if gesture == nil {
            self.gesture = UITapGestureRecognizer(target: self, action: #selector(handle(gesture:)))
            base.isUserInteractionEnabled = true
            if let g = gesture {
                base.addGestureRecognizer(g)
            }
        }
        
        let c: UIColor = marker.color
        let mutable = ((self.base.attributedText) != nil) ? NSMutableAttributedString(attributedString:  self.base.attributedText!) : NSMutableAttributedString(string: attr.string)
        
        
        let attributed = [
            NSAttributedString.Key.underlineStyle: 1,
            NSAttributedString.Key.underlineColor: c ,
            NSAttributedString.Key.foregroundColor: c
            ] as [NSAttributedString.Key : Any]
        
        self.base.attributedText?.string.subStrings(marker.value).forEach({ (r) in
            mutable.addAttributes(attributed, range: r)
            
            if let c = click {
                self.clickMap[r] = (c,marker)
            }
            
        })
        self.base.attributedText = mutable
    }
    
    func subStrings(_ value: String) -> [NSRange] {
        return self.base.attributedText?.string.subStrings(value) ?? [NSRange]()
    }
}


