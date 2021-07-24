//
//  DataManager.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/24.
//

import Foundation
import RxSwift
import RxCocoa

class DataManager {

    func fetchProducts() -> Driver<[Product]> {
        return Driver<[Product]>.just(
            [
                Product(name: "oo", content: "oooo")
                , Product(name: "oo2", content: "oooo")
                , Product(name: "oo3", content: "oooo")
            ]
        )
    }
}
