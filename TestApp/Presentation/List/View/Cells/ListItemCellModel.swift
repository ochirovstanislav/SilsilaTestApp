//
//  ListItemCellModel.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

struct ListItemCellModel: CellModelProtocol, Equatable, IdentifiableType {
    typealias Identity = String

    var identity: String {
        return id
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    static var cellIdentifier = "ListItemCell"

    let id: String
    let title: String
    let isChecked: Bool

    let isCheckedChanged = PublishRelay<Bool>()
}
