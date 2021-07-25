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
    var searchViewModel: SearchViewModel?

    init(navigationController: UINavigationController) {
        self.childCoordinators = []
        self.navigationController = navigationController
    }

    func start() {
        let vc = HomeViewController(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }

    func moveSearchVC() {
        searchViewModel = SearchViewModel()
        guard let searchViewModel = searchViewModel else { return }

        let vc = SearchViewController(viewModel: searchViewModel)
        navigationController.pushViewController(vc, animated: true)

        let searchController = UISearchController(searchResultsController: SearchResultViewController(viewModel: searchViewModel))
        vc.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "검색어를 입력하세요."
    }
}
