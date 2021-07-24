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
        guard let path = Bundle.main.path(forResource: "DataExample", ofType: "json") else {
            return Driver<[Product]>.empty()
        }

        guard let jsonString = try? String(contentsOfFile: path)
              , let data = jsonString.data(using: .utf8) else {
            return Driver<[Product]>.empty()
        }

        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ProductResult.self, from: data)
            let data = result.data
            return Driver<[Product]>.just(data)
        } catch {
            print(error) // todo: 수정
            return Driver<[Product]>.empty()
        }
    }
}
