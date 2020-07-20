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

        for child in childs {
            child.setupTabBarIcon()
        }
        
        viewControllers = childs.map { UINavigationController(rootViewController: $0) }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
