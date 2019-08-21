//
//  DrawLineLayer.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/20.
//

import UIKit
public class DrawLineLayer: CAShapeLayer {
    var direction: Direction = Direction.none {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    public struct Direction: OptionSet {
        public let rawValue: Int
        public static let top = Direction.init(rawValue: 1)
        public static let bottom = Direction.init(rawValue: 2)
        public static let left = Direction.init(rawValue: 4)
        public static let right = Direction.init(rawValue: 8)
        public static let full = Direction.init(rawValue: 16)
        public static let center = Direction.init(rawValue: 32)
        public static let none = Direction.init(rawValue: 0)
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }    
    override public func layoutSublayers() {
        super.layoutSublayers()
        self.draw()
    }
    
    func draw() {
        let bezier = UIBezierPath()
        switch self.direction {
        case .top:
            bezier.move(to: CGPoint(x: 0, y: 0))
            bezier.addLine(to: CGPoint(x: self.frame.width, y: 0))
        case .bottom:
            let y = self.frame.height-(self.lineWidth/2)
            bezier.move(to: CGPoint(x: 0, y: y))
            bezier.addLine(to: CGPoint(x: self.frame.width, y: y))
        case .left:
            bezier.move(to: CGPoint(x: 0, y: 0))
            bezier.addLine(to: CGPoint(x: 0, y: self.frame.height))
        case .right:
            bezier.move(to: CGPoint(x: self.frame.width, y: 0))
            bezier.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        case [.top, .bottom]:
            bezier.move(to: CGPoint(x: 0, y: 0))
            bezier.addLine(to: CGPoint(x: self.frame.width, y: 0))
            bezier.move(to: CGPoint(x: 0, y: self.frame.height))
            bezier.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        case [.top, .left]:
            bezier.move(to: CGPoint(x: 0, y: 0))
            bezier.addLine(to: CGPoint(x: self.frame.width, y: 0))
            bezier.move(to: CGPoint(x: 0, y: 0))
            bezier.addLine(to: CGPoint(x: 0, y: self.frame.height))
        case [.top, .right]:
            bezier.move(to: CGPoint(x: 0, y: 0))
            bezier.addLine(to: CGPoint(x: self.frame.width, y: 0))
            bezier.move(to: CGPoint(x: self.frame.width, y: 0))
            bezier.addLine(to: CGPoint(x: 0, y: self.frame.height))
        case [.bottom, .left]:
            bezier.move(to: CGPoint(x: 0, y: self.frame.height))
            bezier.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
            bezier.move(to: CGPoint(x: 0, y: 0))
            bezier.addLine(to: CGPoint(x: 0, y: self.frame.height))
        case [.bottom, .right]:
            bezier.move(to: CGPoint(x: 0, y: self.frame.height))
            bezier.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
            bezier.move(to: CGPoint(x: 0, y: self.frame.height))
            bezier.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        case [.left, .right]:
            bezier.move(to: CGPoint(x: 0, y: 0))
            bezier.addLine(to: CGPoint(x: 0, y: self.frame.height))
            bezier.move(to: CGPoint(x: 0, y: 0))
            bezier.addLine(to: CGPoint(x: 0, y: self.frame.height))
        case .full:
            bezier.append(UIBezierPath(rect: self.bounds))
        case .center:
            let y = self.frame.height-(self.lineWidth/2)
            bezier.move(to: CGPoint(x: 0, y: y/2))
            bezier.addLine(to: CGPoint(x: self.frame.width, y: y/2))
        case .none:
            bezier.append(UIBezierPath())
        default:
            break
        }
        
        self.path = bezier.cgPath
    }
}
