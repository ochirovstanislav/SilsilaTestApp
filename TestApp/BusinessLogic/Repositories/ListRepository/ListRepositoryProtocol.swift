//
//  ListRepositoryProtocol.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Foundation

protocol ListRepositoryProtocol {

    func addListItem(_ item: ListItemModel) -> Bool
    func deleteListItem(_ item: ListItemModel) -> Bool
    func checkListItem(_ item: ListItemModel) -> Bool
    func uncheckListItem(_ item: ListItemModel) -> Bool
    func updateTitleInListItem(_ item: ListItemModel, newTitle: String) -> Bool
    func updateIsCheckedInListItem(_ item: ListItemModel, isChecked: Bool) -> Bool
    func obtainAllListItems() -> [ListItemModel]
}
