//
//  ListAssembly.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Foundation
import Swinject

final class ListAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ListViewController.self) { r in
            let dataSource = r.resolve(ListViewDataSource.self)!
            let viewModel = r.resolve(ListViewModel.self)!

            return ListViewController(dataSource: dataSource,
                                      viewModel: viewModel)
        }.inObjectScope(.container)

        container.register(ListViewDataSource.self) { r in
            return ListViewDataSource()
        }

        container.register(ListViewModel.self) { r in
            let listRepository = r.resolve(ListRepository.self)!
            let coordinator = r.resolve(ListCoordinator.self)!
            
            return ListViewModel(listRepository: listRepository,
                                 coordinator: coordinator)
        }

        container.register(ListCoordinator.self) { r in
            return ListCoordinator(resolver: r)
        }
    }
}
