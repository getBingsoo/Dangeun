//
//  HomeCoordinator.swift
//  Dangeun
//
//  Created by Lina Choi on 2021/07/21.
//

import UIKit

class HomeCoordinator: Coordinator {

    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.childCoordinators = []
        self.navigationController = navigationController
    }

    func start() {
        let vc = HomeViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
