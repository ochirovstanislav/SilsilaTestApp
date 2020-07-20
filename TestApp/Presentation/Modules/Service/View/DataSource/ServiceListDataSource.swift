//
//  ServiceListDataSource.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ServiceListDataSource: ServiceListDataSourceProtocol {

    private let disposeBag = DisposeBag()

    // Метод для заполнения таблицы
    func setup(tableView: UITableView, cellModels: BehaviorRelay<[ServiceItemCellModel]>) {
        cellModels.bind(to: tableView.rx.items(cellIdentifier: ServiceItemCellModel.cellIdentifier, cellType: ServiceItemCell.self)) {  _, model, cell in
            cell.setup(with: model)
        }.disposed(by: disposeBag)
    }
}
