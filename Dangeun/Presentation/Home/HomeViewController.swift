//
//  HomeViewController.swift
//  Dangeun
//
//  Created by Lina Choi on 2021/07/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    var coordinator: HomeCoordinator
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()

    let topBar = TopBarView()
    let tableView = UITableView()

    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
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

    private func bind() {
        let input = HomeViewModel.Input()
        let output = viewModel.transform(input: input)

        output.products.drive(
            tableView.rx.items(
                cellIdentifier: ProductCell.reuseIdentifier
                , cellType: ProductCell.self
            )
        ) { _, element, cell in
            cell.configureCell(by: element)
        }.disposed(by: disposeBag)
    }

    func moveSearchVC() {
        coordinator.moveSearchVC()
    }
}

extension HomeViewController {

    private func configureUI() {
        self.view.backgroundColor = .white
//        self.navigationController?.isNavigationBarHidden = true

        self.view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
            , topBar.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor)
            , topBar.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
            , topBar.heightAnchor.constraint(equalToConstant: 40)
        ])

        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 10)
            , tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10)
            , tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: 10)
            , tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setTableView() {
        tableView.register(
            ProductCell.self
            , forCellReuseIdentifier: ProductCell.reuseIdentifier
        )

        tableView.rowHeight = 120
    }
}
