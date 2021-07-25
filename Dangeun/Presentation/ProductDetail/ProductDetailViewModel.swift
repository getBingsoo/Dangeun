//
//  ProductDetailViewModel.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/25.
//

import Foundation
import RxSwift
import RxCocoa

class ProductDetailViewModel: ViewModelType {

    let dataManager = DataManager()

    var product: BehaviorRelay<Product?> = BehaviorRelay(value: nil)

    init(product: Product) {
        self.product.accept(product)
    }

    func transform(input: Input) -> Output {

        let product = input.viewFirstLoaded.filter { [weak self] _ in
            self?.product.value?.link != nil
        }.flatMap { [weak self] _ -> Observable<Product> in
            guard let self = self else { return Observable.empty() }
            return self.dataManager.fetchProductDetail(link: self.product.value!.link)
        }.asDriver(onErrorDriveWith: Driver<Product>.empty())

        return Output(product: product)
    }
}

extension ProductDetailViewModel {
    struct Input {
        let viewFirstLoaded: PublishRelay<Void>
    }

    struct Output {
        let product: Driver<Product>
    }
}
