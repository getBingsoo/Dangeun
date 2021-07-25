//
//  SearchViewModel.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/25.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: ViewModelType {

    let dataManager = DataManager()

    var searchList: BehaviorRelay<[Product]> = BehaviorRelay(value: [])

    func transform(input: Input) -> Output {

        let search = input.searchTrigger.withLatestFrom(input.searchText) {
            return $1
        }

        let resultList = search.flatMap { [weak self] searchText -> Driver<[Product]> in
            guard let self = self else { return Driver<[Product]>.empty() }
            let result = self.dataManager.fetchProducts(searchText: searchText).map { [weak self] list -> [Product] in
                guard let self = self else { return [] }
                self.searchList.accept(list)
                return list
            }.asDriver(onErrorDriveWith: Driver<[Product]>.empty())
            return result
        }
        return Output(resultList: resultList)
    }
}

extension SearchViewModel {
    struct Input {
        let searchTrigger: Driver<Void>
        let searchText: Driver<String>
    }

    struct Output {
        let resultList: Driver<[Product]>
    }
}
