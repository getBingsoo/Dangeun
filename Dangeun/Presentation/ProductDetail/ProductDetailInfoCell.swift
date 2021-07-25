//
//  ProductDetailInfoCell.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/26.
//

import UIKit

class ProductDetailInfoCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentLabel)
        self.contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20)
            , stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
            , stackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor)
            , stackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(product: Product) {
        self.titleLabel.text = product.title
        self.contentLabel.text = product.content
    }
}
