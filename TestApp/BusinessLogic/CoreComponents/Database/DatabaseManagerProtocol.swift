//
//  DatabaseManagerProtocol.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import RealmSwift

protocol DatabaseManagerProtocol {

    func obtainAllItems<Type: Object>() -> [Type]
    func addItem<Type: Object>(_ item: Type) -> Bool
    func deleteItem<Type: Object>(_ item: Type) -> Bool
    func updateItem(updateClosure: (() -> Void)) -> Bool
}
