//
//  SearchViewController.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/25.
//

import UIKit
import RxSwift
import RxCocoa

/// 홈 -> 검색 누르면 나오는, 검색창이 있는 뷰컨트롤러
class SearchViewController: UIViewController {

    var viewModel: SearchViewModel
    let disposeBag = DisposeBag()

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        bind()
    }

    func bind() {
        guard let searchBar = self.navigationItem.searchController?.searchBar else { return }

        let input = SearchViewModel.Input(
            searchTrigger: searchBar.rx.searchButtonClicked.asDriver()
            , searchText: searchBar.rx.text.orEmpty.asDriver()
            , resetTrigger: searchBar.rx.textDidBeginEditing.asDriver()
        )

        let output = viewModel.transform(input: input)

        output.resultList.drive().disposed(by: disposeBag)
    }
}

extension SearchViewController {

    private func configureUI() {
        self.view.backgroundColor = .white
    }
}
