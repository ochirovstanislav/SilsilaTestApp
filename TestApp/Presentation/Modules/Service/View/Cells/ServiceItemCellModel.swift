//
//  ServiceItemCellModel.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Foundation

struct ServiceItemCellModel: CellModelProtocol {
    static var cellIdentifier = "ServiceItemCell"

    var title: String?
    var artist: String?
    var country: String?
    var company: String?
    var price: String?
    var year: String?
}
