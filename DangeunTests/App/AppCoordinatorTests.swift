//
//  AppCoordinatorTests.swift
//  DangeunTests
//
//  Created by Lina Choi on 2021/07/21.
//

import XCTest
@testable import Dangeun

class AppCoordinatorTests: XCTestCase {

    var sut: AppCoordinator!

    override func setUp() {
        super.setUp()

        sut = AppCoordinator(window: UIWindow(frame: UIScreen.main.bounds))
    }

    override func tearDown() {

    }

    func test_whenStartAppCoordinator_thenStartHomeCoordinatorCalled() throws {
        // given
        let homeCoordinator = HomeCoordinatorSpy(navigationController: sut.navigationController)
        sut.childCoordinators = [homeCoordinator]

        // when
        sut.start()

        // then
        XCTAssert(homeCoordinator.isStartCalled)
    }

    /// Test Doubles
    class HomeCoordinatorSpy: Coordinator {

        var isStartCalled = false

        var childCoordinators: [Coordinator] = []
        var navigationController: UINavigationController

        init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }

        func start() {
            isStartCalled = true
        }
    }

}
