//
//  ListItemModel.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Foundation
import RealmSwift

// Сущность со списка на первом экране
final class ListItemModel: Object {

    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var isChecked: Bool = false

    override class func primaryKey() -> String? {
        return "id"
    }

    init(title: String) {
        self.title = title
    }

    required init() { }
}
