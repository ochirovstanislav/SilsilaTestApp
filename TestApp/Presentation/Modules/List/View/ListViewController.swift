//
//  ListViewController.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ListViewController: UIViewController, TabBarChildProtocol {

    // MARK: - TabBarChildProtocol
    var itemTitle: String = LocalizedStrings.list
    var itemIcon: UIImage? = UIImage(named: "ListIcon")

    private let dataSource: ListViewDataSourceProtocol
    private let viewModel: ListViewModel

    private lazy var tableView: UITableView = {
        let outputTableView = UITableView()

        outputTableView.translatesAutoresizingMaskIntoConstraints = false
        outputTableView.tableFooterView = UIView()
        outputTableView.register(ListItemCell.self, forCellReuseIdentifier: ListItemCellModel.cellIdentifier)
        return outputTableView
    }()

    private lazy var addButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    private var onEditTap = PublishRelay<IndexPath>()
    private let disposeBag = DisposeBag()

    init(dataSource: ListViewDataSourceProtocol, viewModel: ListViewModel) {
        self.dataSource = dataSource
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("ListViewController: init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

// MARK: - Private
extension ListViewController {

    private func setup() {
        title = itemTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = addButton
        dataSource.setup(tableView: tableView,
                         cellModels: viewModel.cellModels,
                         onEditTap: onEditTap)

        setupLayout()
        bindUI()
    }

    private func bindUI() {
        addButton.rx.tap.subscribe(onNext: { [weak self] (_) in
            self?.viewModel.onAddTap()
        }).disposed(by: disposeBag)

        tableView.rx
            .itemDeleted
            .asDriver()
            .drive(onNext: { [weak self] indexPath in
                self?.viewModel.onDelete(at: indexPath.row)
            })
            .disposed(by: disposeBag)

        Observable<IndexPath>
            .merge(tableView.rx.itemSelected.asObservable(),
                   onEditTap.asObservable())
            .subscribe(onNext: { [weak self] (indexPath) in self?.viewModel.onEditTap(at: indexPath.row) })
            .disposed(by: disposeBag)
    }

    private func setupLayout() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}



