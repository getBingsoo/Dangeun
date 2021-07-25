//
//  AppCoordinator.swift
//  Dangeun
//
//  Created by Lina Choi on 2021/07/21.
//

import UIKit

class AppCoordinator: Coordinator {

    let window: UIWindow
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        self.childCoordinators = []
        self.navigationController = UINavigationController()
        addChildCoordinators()
    }

    func addChildCoordinators() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        childCoordinators.append(homeCoordinator)
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        childCoordinators[0].start()
    }
}
