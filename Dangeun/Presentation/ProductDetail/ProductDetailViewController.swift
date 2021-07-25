//
//  ProductDetailViewController.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/25.
//

import UIKit
import RxSwift
import RxCocoa

class ProductDetailViewController: UIViewController {

    var viewModel: ProductDetailViewModel

    var viewFirstLoaded = PublishRelay<Void>()
    let disposeBag = DisposeBag()

    let productImage: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()

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

    lazy var userView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()

    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    lazy var productView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

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
        bind()

        viewFirstLoaded.accept(())
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

        self.view.addSubview(userView)
        userView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            userView.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 10)
            , userView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20)
            , userView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])

        self.view.addSubview(productView)
        productView.addArrangedSubview(titleLabel)
        productView.addArrangedSubview(contentLabel)
        productView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            productView.topAnchor.constraint(equalTo: userView.bottomAnchor)
            , productView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20)
            , productView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])


        userView.addSubview(userIcon)
        userIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userIcon.centerYAnchor.constraint(equalTo: userView.centerYAnchor)
            , userIcon.leftAnchor.constraint(equalTo: userView.leftAnchor)
            , userIcon.widthAnchor.constraint(equalToConstant: 40)
            , userIcon.heightAnchor.constraint(equalToConstant: 40)
        ])

        userView.addSubview(nickNameLabel)
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nickNameLabel.topAnchor.constraint(equalTo: userView.topAnchor, constant: 20)
            , nickNameLabel.leftAnchor.constraint(equalTo: userIcon.rightAnchor, constant: 10)
        ])

        userView.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 5)
            , locationLabel.bottomAnchor.constraint(equalTo: userView.bottomAnchor, constant: -20)
            , locationLabel.leftAnchor.constraint(equalTo: userIcon.rightAnchor, constant: 10)
        ])

        self.view.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: productView.bottomAnchor, constant: 5)
            , priceLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            , priceLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20)
        ])
        priceLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    }

    func bind() {
        let input = ProductDetailViewModel.Input(viewFirstLoaded: viewFirstLoaded)
        let output = viewModel.transform(input: input)

        output.product.drive(onNext: { [weak self] product in
            guard let self = self else { return }
            self.nickNameLabel.text = product.nickName
            self.locationLabel.text = product.location

            self.titleLabel.text = product.title
            self.contentLabel.text = product.content
            self.productImage.loadImage(from: product.images[0])

            self.priceLabel.text = "가격 \(product.price)"
        }).disposed(by: disposeBag)
    }
}
