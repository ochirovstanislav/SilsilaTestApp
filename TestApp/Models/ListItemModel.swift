//
//  ListItemModel.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Foundation
import RealmSwift

final class ListItemModel: Object {

    @objc dynamic var title: String = ""
    @objc dynamic var isChecked: Bool = false

    // Уникальность объекта будет определяться по тайтлу

    override class func primaryKey() -> String? {
        return "title"
    }
}
