//
//  ListCoordinator.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit
import Swinject

final class ListCoordinator: Coordinator {

    private var resolver: Resolver
    private lazy var baseController: UIViewController? = resolver.resolve(ListViewController.self)

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    /*
     Открываю экран с редактированием ListItem модально потому-что есть некоторые проблемы с подтверждением изменений по кнопке назад.
     Во-первых, необходимо будет создавать кастомную кнопку и вешать на нее action.
     Во-вторых, даже если мы создадим кастомную кнопку, остается уход с экрана по свайпу назад.
     */

    func performTransition(transition: Transition) {
        switch transition {
        case .listItemMenu(let initialTitle, let onUpdateAction):
            let destinationVC = resolver.resolve(ListItemMenuViewController.self,
                                                 arguments: initialTitle, onUpdateAction)!

            DispatchQueue.main.async {
                self.baseController?.present(destinationVC, animated: true)
            }
        }
    }
}
