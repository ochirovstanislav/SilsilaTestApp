//
//  AppManager.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit
import Swinject

final class AppManager: AppManagerProtocol {

    // Список assembly - модулей, необходимых для инъекции зависимостей
    var assembler = Assembler([
        ListAssembly(),
        RepositoriesAssembly(),
        CoreComponentsAssembly(),
        TabBarAssembly(),
        ListItemMenuAssembly(),
        ServiceListAssembly(),
        ServiceAssembly()
    ])

    var initialViewController: UIViewController {
        assembler.resolver.resolve(TabBarController.self)!
    }
}
