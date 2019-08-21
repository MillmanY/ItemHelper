//
//  CGPoint.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/21.
//

import Foundation
extension CGPoint {
    public func distance(location: CGPoint) -> CGFloat {
        let disX = location.x-self.x
        let disY = location.y-self.y
        return sqrt((disX*disX)+(disY*disY))
    }
}
