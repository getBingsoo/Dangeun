//
//  ProductCell.swift
//  Dangeun
//
//  Created by Lina Choi on 2021/07/22.
//

import UIKit
import RxSwift
import RxCocoa

class ProductCell: UITableViewCell {

    let productImage = CustomImageView()
    let titleLabel = UILabel()
    let locationLabel = UILabel()
    let priceLabel = UILabel()

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
            , productImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            , productImage.heightAnchor.constraint(equalToConstant: 100)
            , productImage.widthAnchor.constraint(equalToConstant: 100)
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
            , titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])

        contentView.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor)
            , locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
            , locationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])

        contentView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.leftAnchor.constraint(equalTo: locationLabel.leftAnchor)
            , priceLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10)
            , priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
    }

    func configureCell(by product: Product) {
        titleLabel.text = product.title
        productImage.loadImage(from: product.images[0])
        locationLabel.text = product.location
        priceLabel.text = "\(product.price)원"
    }
}
