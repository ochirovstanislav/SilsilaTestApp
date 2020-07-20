//
//  ServiceAssembly.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Swinject

// DI для сервисов

final class ServiceAssembly: Assembly {

    func assemble(container: Container) {
        
        container.register(ServiceListService.self) { r in
            return ServiceListService()
        }
    }
}
