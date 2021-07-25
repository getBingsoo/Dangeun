//
//  TopBarView.swift
//  Dangeun
//
//  Created by Lina Choi on 2021/07/22.
//

import UIKit

class TopBarView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
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

    init() {
        super.init(frame: .zero)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            , titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20)
        ])
        titleLabel.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)

        self.addSubview(buttons)
        buttons.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttons.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            , buttons.leftAnchor.constraint(equalTo: self.titleLabel.rightAnchor, constant: 10)
            , buttons.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])

        // add buttons
        let searchButton = UIButton()
        let menuButton = UIButton()
        let alarmButton = UIButton()
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
        if let parentVC = parentViewController as? HomeViewController {
            parentVC.moveSearchVC()
        }
    }
}
