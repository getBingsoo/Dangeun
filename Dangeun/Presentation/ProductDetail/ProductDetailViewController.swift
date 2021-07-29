//
//  ProductDetailViewController.swift
//  Dangeun
//
//  Created by 60067667 on 2021/07/25.
//

import UIKit
import RxSwift
import RxCocoa
import Then

/// 검색 결과 상세 뷰 컨트롤러
class ProductDetailViewController: UIViewController {

    var viewModel: ProductDetailViewModel

    var viewFirstLoaded = PublishRelay<Void>()
    let disposeBag = DisposeBag()

    // MARK: - views
    let productImage = CustomImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
    }

    let userIcon = UIImageView().then {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 20
    }

    let nickNameLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.numberOfLines = 0
    }

    let locationLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
    }

    let userView = UIView()

    let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 18)
        $0.numberOfLines = 0
    }

    let contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.numberOfLines = 0
    }

    let priceLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 15)
        $0.numberOfLines = 0
    }

    let productView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
    }

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

    private func bind() {
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

extension ProductDetailViewController {

    private func configureUI() {
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

}
