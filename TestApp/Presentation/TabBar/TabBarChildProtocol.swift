//
//  TabBarChildProtocol.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit

protocol TabBarChildProtocol where Self: UIViewController  {
    var itemTitle: String { get }
    var itemIcon: UIImage? { get }

    func setupTabBarIcon()
}

extension TabBarChildProtocol {

    func setupTabBarIcon() {
        tabBarItem = UITabBarItem(title: itemTitle, image: itemIcon, selectedImage: nil)
    }
}
