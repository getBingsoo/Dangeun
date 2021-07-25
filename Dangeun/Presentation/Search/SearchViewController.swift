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
        )

        let _ = viewModel.transform(input: input)
    }
}

extension SearchViewController {

    private func configureUI() {
        self.view.backgroundColor = .white
    }
}
