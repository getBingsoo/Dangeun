//
//  ProductDetailViewController.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/25.
//

import UIKit

class ProductDetailViewController: UIViewController {

    var viewModel: ProductDetailViewModel

    let productImage = CustomImageView()
    let detailStackView = UIStackView()
    let tableView = UITableView()

    let nickNameLabel = UILabel()

    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureOutput()
    }

    func configureUI() {
        self.view.backgroundColor = .white

        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        self.view.addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: self.view.topAnchor)
            , productImage.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor)
            , productImage.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
            , productImage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5)
        ])

        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: productImage.bottomAnchor)
            , tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20)
            , tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20)
            , tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        tableView.register(ProductDetailUserCell.self, forCellReuseIdentifier: ProductDetailUserCell.reuseIdentifier)
        tableView.register(ProductDetailInfoCell.self, forCellReuseIdentifier: ProductDetailInfoCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }

    func configureOutput() {
        productImage.loadImage(from: viewModel.product.images[0])
        nickNameLabel.text = viewModel.product.title
    }
}

extension ProductDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailUserCell.reuseIdentifier, for: indexPath) as! ProductDetailUserCell

                cell.configureCell(product: viewModel.product)

                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailInfoCell.reuseIdentifier, for: indexPath) as! ProductDetailInfoCell
                cell.configureCell(product: viewModel.product)

                return cell
        }
    }
}
