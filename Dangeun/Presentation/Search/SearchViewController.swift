//
//  SearchViewController.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/25.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        bind()
    }

    func bind() {
        guard let searchBar = self.navigationItem.searchController?.searchBar else { return }

        let input =  SearchViewModel.Input(
            searchTrigger: searchBar.rx.searchButtonClicked.asDriver()
            , searchText: searchBar.rx.text.orEmpty.asDriver()
        )

        let output = viewModel.transform(input: input)

        output.resultList.drive(onNext: { result in
            print(result)
        }).disposed(by: disposeBag)
    }
}

extension SearchViewController {

    private func configureUI() {
        self.view.backgroundColor = .white

        // navigation
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "검색어를 입력하세요."
    }
}
