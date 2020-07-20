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

final class ListViewDataSource: NSObject, ListViewDataSourceProtocol, UITableViewDelegate {
    typealias CellModel = AnimatableSectionModel<String, ListItemCellModel>

    // RxTableViewSectionedAnimatedDataSource необходим для анимированного обновления таблицы
    private lazy var dataSource: RxTableViewSectionedAnimatedDataSource<CellModel> = {
        RxTableViewSectionedAnimatedDataSource<CellModel>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .right,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .top),
            configureCell: configureCell,
            canEditRowAtIndexPath: canEditRowAtIndexPath
        )
    }()
    private var onEditTap: PublishRelay<IndexPath>?
    private let disposeBag = DisposeBag()
    private var tableView: UITableView?

    private var configureCell: RxTableViewSectionedAnimatedDataSource<CellModel>.ConfigureCell {
        return { _, tableView, indexPath, cellModel in
            let cell = tableView.dequeueReusableCell(withIdentifier: ListItemCellModel.cellIdentifier) as! CellProtocol
            cell.setup(with: cellModel)
            return cell
        }
    }

    // Разрешаем редактирование таблицы - удаление по свайпу
    private var canEditRowAtIndexPath: RxTableViewSectionedAnimatedDataSource<CellModel>.CanEditRowAtIndexPath {
        return { _, _ in
            return true
        }
    }

    func setup(tableView: UITableView, cellModels: BehaviorRelay<[ListItemCellModel]>, onEditTap: PublishRelay<IndexPath>?) {
        self.onEditTap = onEditTap
        self.tableView = tableView
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        cellModels
            .map { [CellModel(model: "", items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    // Создание кастомных кнопок в менюшке по свайпу
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: LocalizedStrings.delete) { [weak self] (action, indexPath) in
            self?.tableView?.dataSource?.tableView?(tableView, commit: .delete, forRowAt: indexPath)
            return
        }

        let editButton = UITableViewRowAction(style: .normal, title: LocalizedStrings.edit) { (_, indexPath) in
            self.onEditTap?.accept(indexPath)
            return
        }
        return [deleteButton, editButton]
    }
}
