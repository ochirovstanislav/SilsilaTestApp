//
//  CoreComponentsAssembly.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Swinject

final class CoreComponentsAssembly: Assembly {

    func assemble(container: Container) {
        
        container.register(DatabaseManager.self) { r in
            return DatabaseManager()
        }
    }
}
