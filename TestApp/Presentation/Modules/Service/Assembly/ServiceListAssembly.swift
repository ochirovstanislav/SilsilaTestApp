//
//  ServiceListAssembly.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Swinject

final class ServiceListAssembly: Assembly {

    func assemble(container: Container) {

        // View
        container.register(ServiceListViewController.self) { r in
            let viewModel = r.resolve(ServiceListViewModel.self)!
            let dataSource = r.resolve(ServiceListDataSource.self)!

            return ServiceListViewController(dataSource: dataSource, viewModel: viewModel)
        }

        // ViewModel
        container.register(ServiceListViewModel.self) { r in
            let serviceRepository = r.resolve(ServiceRepository.self)!

            return ServiceListViewModel(serviceRepository: serviceRepository)
        }

        // DataSource для заполнения таблицы
        container.register(ServiceListDataSource.self) { r in
            return ServiceListDataSource()
        }
    }
}
