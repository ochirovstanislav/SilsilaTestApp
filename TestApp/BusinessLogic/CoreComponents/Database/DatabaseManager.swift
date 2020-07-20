//
//  DatabaseManager.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import RealmSwift

final class DatabaseManager: DatabaseManagerProtocol {

    private let realm = try! Realm()

    func obtainAllItems<Type: Object>() -> [Type] {
        return Array(realm.objects(Type.self))
    }

    func addItem<Type: Object>(_ item: Type) -> Bool {
        do {
            try realm.safeWrite { realm.add(item) }
            return true
        } catch {
            return false
        }
    }

    func deleteItem<Type: Object>(_ item: Type) -> Bool {
        do {
            try realm.safeWrite { realm.delete(item) }
            return true
        } catch {
            return false
        }
    }

    func updateItem(updateClosure: (() -> Void)) -> Bool {
        do {
            try realm.safeWrite { updateClosure() }
            return true
        } catch {
            return false
        }
    }
}
