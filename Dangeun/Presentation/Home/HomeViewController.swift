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

    let tableView = UITableView()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "역삼1동"
        return label
    }()

    let buttons: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10

        return stackView
    }()

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

        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10)
            , tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10)
            , tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: 10)
            , tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        // navigation items
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttons)

        // add navigation buttons
        let searchButton = UIButton()
        let menuButton = UIButton()
        menuButton.isHidden = true
        let alarmButton = UIButton()
        alarmButton.isHidden = true
        if #available(iOS 13.0, *) {
            searchButton.setImage(UIImage(systemName: "magnifyingglass")!, for: .normal)
            menuButton.setImage(UIImage(systemName: "list.dash")!, for: .normal)
            alarmButton.setImage(UIImage(systemName: "bell")!, for: .normal)
        } else {
            // todo
        }

        buttons.addArrangedSubview(searchButton)
        buttons.addArrangedSubview(menuButton)
        buttons.addArrangedSubview(alarmButton)

        searchButton.addTarget(self, action: #selector(searchButtonTouched), for: .touchUpInside)
    }

    @objc func searchButtonTouched() {
        self.moveSearchVC()
    }

    private func setTableView() {
        tableView.register(
            ProductCell.self
            , forCellReuseIdentifier: ProductCell.reuseIdentifier
        )

        tableView.rx.modelSelected(Product.self).asDriver().drive(onNext: { [weak self] product in
            self?.coordinator.moveDetailVC(product: product)
        }).disposed(by: disposeBag)

        tableView.rowHeight = 120
    }
}
