//
//  ProductDetailUserCell.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/26.
//

import UIKit

class ProductDetailUserCell: UITableViewCell {

    lazy var userIcon: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 20
        return iv
    }()

    lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none

        self.contentView.addSubview(userIcon)
        userIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userIcon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
            , userIcon.leftAnchor.constraint(equalTo: self.contentView.leftAnchor)
            , userIcon.widthAnchor.constraint(equalToConstant: 40)
            , userIcon.heightAnchor.constraint(equalToConstant: 40)
        ])

        stackView.addArrangedSubview(nickNameLabel)
        stackView.addArrangedSubview(locationLabel)
        self.contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20)
            , stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
            , stackView.leftAnchor.constraint(equalTo: self.userIcon.rightAnchor, constant: 10)
            , stackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(product: Product) {
        self.nickNameLabel.text = product.title
        self.locationLabel.text = product.location
    }
}
