//
//  ArrayHelper.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/21.
//

import Foundation

extension Array {
    subscript(safe idx: Int) -> Element? {
        return indices ~= idx ? self[idx] : nil
    }
}
