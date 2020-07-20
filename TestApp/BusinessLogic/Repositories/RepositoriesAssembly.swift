//
//  RepositoriesAssembly.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Swinject

// DI для репозиториев

final class RepositoriesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ListRepository.self) { r in
            let databaseManager = r.resolve(DatabaseManager.self)!

            return ListRepository(databaseManager: databaseManager)
        }

        container.register(ServiceRepository.self) { r in
            let xmlParserManager = r.resolve(XMLParserManager.self)!
            let serviceListService = r.resolve(ServiceListService.self)!

            return ServiceRepository(serviceListService: serviceListService,
                                     xmlParserManager: xmlParserManager)
        }
    }
}
