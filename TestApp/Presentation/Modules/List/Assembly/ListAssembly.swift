//
//  ListAssembly.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Foundation
import Swinject

// DI для list модуля
final class ListAssembly: Assembly {

    func assemble(container: Container) {

        // View
        container.register(ListViewController.self) { r in
            let dataSource = r.resolve(ListViewDataSource.self)!
            let viewModel = r.resolve(ListViewModel.self)!

            return ListViewController(dataSource: dataSource,
                                      viewModel: viewModel)
        }.inObjectScope(.container)

        // DataSource для заполнения таблицы
        container.register(ListViewDataSource.self) { r in
            return ListViewDataSource()
        }

        // ViewModel
        container.register(ListViewModel.self) { r in
            let listRepository = r.resolve(ListRepository.self)!
            let coordinator = r.resolve(ListCoordinator.self)!
            
            return ListViewModel(listRepository: listRepository,
                                 coordinator: coordinator)
        }

        // Coordinator
        container.register(ListCoordinator.self) { r in
            return ListCoordinator(resolver: r)
        }
    }
}
