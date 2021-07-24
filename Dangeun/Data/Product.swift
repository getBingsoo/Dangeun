//
//  Product.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/24.
//

import Foundation

struct Product: Codable {
    let title: String
    let price: String
    let location: String
    let content: String
    let images: [String]
}

struct ProductResult: Codable {
    let code: String
    let data: [Product]
}
