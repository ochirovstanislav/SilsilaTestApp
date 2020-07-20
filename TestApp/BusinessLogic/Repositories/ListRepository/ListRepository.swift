//
//  ListRepository.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Foundation

// Репозиторий для работы с ListItem сущностями. Прослойка между бизнес логикой и данными.

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

    func updateTitleInListItem(_ item: ListItemModel, newTitle: String) -> Bool {
        return databaseManager.updateItem {
            item.title = newTitle
        }
    }

    func updateIsCheckedInListItem(_ item: ListItemModel, isChecked: Bool) -> Bool {
        return databaseManager.updateItem {
            item.isChecked = isChecked
        }
    }
}
