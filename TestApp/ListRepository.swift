//
//  ListRepository.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Foundation

// 

protocol ListRepositoryProtocol {

    func addListItem(_ item: ListItemModel) -> Bool
    func deleteListItem(_ item: ListItemModel) -> Bool
    func checkListItem(_ item: ListItemModel) -> Bool
    func uncheckListItem(_ item: ListItemModel) -> Bool
    func updateListItem(_ item: ListItemModel, newTitle: String) -> Bool
    func obtainAllListItems() -> [ListItemModel]
}

final class ListRepository {

    private let databaseManager: DatabaseManagerProtocol

    init(databaseManager: DatabaseManagerProtocol) {
        self.databaseManager = databaseManager
    }
}

extension ListRepository: ListRepositoryProtocol {

    func obtainAllListItems() -> [ListItemModel] {
        return databaseManager.obtainAllItems()
    }

    func addListItem(_ item: ListItemModel) -> Bool {
        return databaseManager.addItem(item)
    }

    func deleteListItem(_ item: ListItemModel) -> Bool {
        return databaseManager.deleteItem(item)
    }

    func checkListItem(_ item: ListItemModel) -> Bool {
        return databaseManager.updateItem {
            item.isChecked = true
        }
    }

    func uncheckListItem(_ item: ListItemModel) -> Bool {
        return databaseManager.updateItem {
            item.isChecked = false
        }
    }

    func updateListItem(_ item: ListItemModel, newTitle: String) -> Bool {
        return databaseManager.updateItem {
            item.title = newTitle
        }
    }
}
