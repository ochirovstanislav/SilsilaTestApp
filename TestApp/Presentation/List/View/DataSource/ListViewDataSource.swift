//
//  ListViewDataSource.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class ListViewDataSource: ListViewDataSourceProtocol {
    typealias CellModel = AnimatableSectionModel<String, ListItemCellModel>

    private lazy var dataSource: RxTableViewSectionedAnimatedDataSource<CellModel> = {
        RxTableViewSectionedAnimatedDataSource<CellModel>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .right,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .top),
            configureCell: configureCell,
            canEditRowAtIndexPath: canEditRowAtIndexPath
        )
    }()
    private let disposeBag = DisposeBag()

    private var configureCell: RxTableViewSectionedAnimatedDataSource<CellModel>.ConfigureCell {
        return { _, tableView, indexPath, cellModel in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListItemCellModel.cellIdentifier) as! CellProtocol
            cell.setup(with: cellModel)
            return cell
        }
    }

    private var canEditRowAtIndexPath: RxTableViewSectionedAnimatedDataSource<CellModel>.CanEditRowAtIndexPath {
        return { _, _ in
            return true
        }
    }

    func setup(tableView: UITableView, cellModels: BehaviorRelay<[ListItemCellModel]>) {
        cellModels
            .map { [CellModel(model: "", items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
