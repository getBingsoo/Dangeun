//
//  ProductCell.swift
//  Dangeun
//
//  Created by Lina Choi on 2021/07/22.
//

import UIKit

class ProductCell: UITableViewCell {

    let productImage = UIImageView()
    let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        contentView.addSubview(productImage)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
            , productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
            , productImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        if #available(iOS 13.0, *) {
            productImage.image = UIImage(systemName: "doc")
        } else {
        }

        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 10)
            , titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
            , titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configureCell(by product: Product) {
        titleLabel.text = product.title
    }
}
