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

    var assembler = Assembler([
        ListAssembly(),
        RepositoriesAssembly(),
        CoreComponentsAssembly(),
        TabBarAssembly(),
        ListItemMenuAssembly()
    ])

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let initialVC = assembler.resolver.resolve(TabBarController.self)
        let window = UIWindow(frame: UIScreen.main.bounds)

        window.rootViewController = initialVC
        self.window = window
        window.makeKeyAndVisible()

        return true
    }


}

