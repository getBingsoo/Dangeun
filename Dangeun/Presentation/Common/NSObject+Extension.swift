//
//  NSObject+Extension.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/24.
//

import Foundation

extension NSObject {

    static var reuseIdentifier: String {
        String(describing: self)
    }
}
