//
//  Coordinator.swift
//  Dangeun
//
//  Created by Lina Choi on 2021/07/21.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
