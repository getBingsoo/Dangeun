//
//  SearchResultViewController.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/25.
//

import UIKit
import RxSwift
import RxCocoa

class SearchResultViewController: UIViewController {

    var viewModel: SearchViewModel
    let disposeBag = DisposeBag()
    let tableView = UITableView()

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
        setTableView()
        bind()
    }

    func bind() {
        viewModel.searchList.asDriver().drive(
            tableView.rx.items(cellIdentifier: ProductCell.reuseIdentifier, cellType: ProductCell.self)) { _, element, cell in
            cell.configureCell(by: element)
            }.disposed(by: disposeBag)
    }
}

extension SearchResultViewController {

    private func configureUI() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
            , tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor)
            , tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
            , tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIdentifier)
    }

    private func setTableView() {
        tableView.register(
            ProductCell.self
            , forCellReuseIdentifier: ProductCell.reuseIdentifier
        )

        tableView.rowHeight = 120
    }
}
