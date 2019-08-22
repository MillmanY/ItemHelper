//
//  CodableHelper.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/21.
//

import Foundation
extension Dictionary {
    var jsonString: String {
        get {
            if let json = try? JSONSerialization.data(withJSONObject: self, options: .sortedKeys),
                let value = String.init(data: json, encoding: .utf8) {
                return value
            } else {
                return ""
            }
        }
    }
}
extension Encodable {
    /**
     ItemHelper Extension
     ```
     Model to json
     ```
     */
    public var info: [String: Any] {
        get {
            guard let data = try? JSONEncoder().encode(self),
                let object = try? JSONSerialization.jsonObject(with: data),
                let json = object as? [String: Any] else {
                    return [String: Any]()
            }
            return json.compactMapValues({ $0 })
        }
    }
}
