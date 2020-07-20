//
//  AppDelegate.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let appManager: AppManagerProtocol = AppManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let initialVC = appManager.initialViewController
        let window = UIWindow(frame: UIScreen.main.bounds)

        window.rootViewController = initialVC
        self.window = window
        window.makeKeyAndVisible()

        return true
    }
}

