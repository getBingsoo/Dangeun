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

    func transform(input: Input) -> Output {

        let search = input.searchTrigger.withLatestFrom(input.searchText) {
            return $1
        }

        let resultList = search.flatMap { [weak self] searchText -> Driver<[Product]> in
            guard let self = self else { return Driver<[Product]>.empty() }
            return self.dataManager.fetchProducts(searchText: searchText).asDriver(onErrorDriveWith: Driver<[Product]>.empty())
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
