//
//  AppDelegate.swift
//  Dangeun
//
//  Created by Lina Choi on 2021/07/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = AppCoordinator(window: window!)
        coordinator.start()

        return true
    }

}

