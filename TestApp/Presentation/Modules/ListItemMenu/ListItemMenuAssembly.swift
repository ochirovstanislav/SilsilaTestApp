//
//  ListItemMenuAssembly.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Swinject
import RxSwift
import RxCocoa

final class ListItemMenuAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ListItemMenuViewController.self) { (r, initialTitle: String, onUpdateAction: PublishRelay<String>?) in
            return ListItemMenuViewController(initialTitle: initialTitle, onUpdateAction: onUpdateAction)
        }
    }
}
