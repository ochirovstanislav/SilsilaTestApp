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
