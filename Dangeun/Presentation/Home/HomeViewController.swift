//
//  HomeViewController.swift
//  Dangeun
//
//  Created by Lina Choi on 2021/07/21.
//

import UIKit

class HomeViewController: UIViewController {

    let topBar = TopBarView()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTableView()
    }

    private func configureUI() {
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true

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
        self.tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        self.tableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell {
            cell.titleLabel.text = "oo"
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
