//
//  HomeViewModel.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/24.
//

import Foundation
import RxCocoa

class HomeViewModel: ViewModelType {

    let dataManager = DataManager()

    func transform(input: Input) -> Output {
        let products = dataManager.fetchProducts()

        return Output(
            products: products
        )
    }
}

extension HomeViewModel {

    struct Input {

    }

    struct Output {
        let products: Driver<[Product]>
    }
}
