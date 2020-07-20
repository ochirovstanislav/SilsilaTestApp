//
//  TabBarAssembly.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Swinject

final class TabBarAssembly: Assembly {

    func assemble(container: Container) {
        container.register(TabBarController.self) { r in
            let firstVC = r.resolve(ListViewController.self)!
            let secondVC = r.resolve(ServiceListViewController.self)!

            return TabBarController(childs: [firstVC, secondVC])
        }
    }
}
