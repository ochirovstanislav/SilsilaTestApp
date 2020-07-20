//
//  CellProtocol.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit

// Протокол для ячейки таблицы с инъекцией модели ячейки
protocol CellProtocol where Self: UITableViewCell {
    func setup(with cellModel: CellModelProtocol)
}
