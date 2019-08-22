//
//  URLComponentHelper.swift
//  ItemHelper
//
//  Created by Millman on 2019/8/21.
//

import Foundation
extension URLComponents {
    /**
     ItemHelper Extension
     ```
     URLComponents parameter
     ```
     */
    public var itemMap: [String: String] {
        get {
            var parameter = [String: String]()
            self.queryItems?.forEach({ (item) in
                parameter[item.name] = item.value ?? ""
            })
            return parameter
        }
    }
}
