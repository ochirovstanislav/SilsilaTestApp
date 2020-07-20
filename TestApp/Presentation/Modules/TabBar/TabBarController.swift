//
//  TabBarController.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {

    init(childs: [TabBarChildProtocol]) {
        super.init(nibName: nil, bundle: nil)

        /*
         - Сетапим иконку и тайтлы для пункта таббара
         - Заворачиваем каждый дочерний экран в UINavigationController
         */
        viewControllers = childs.map {
            $0.setupTabBarIcon()
            return UINavigationController(rootViewController: $0)
        }

        tabBar.isTranslucent = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
