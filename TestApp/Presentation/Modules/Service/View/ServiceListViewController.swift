//
//  ServiceListViewController.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ServiceListViewController: UIViewController, TabBarChildProtocol {

    // MARK: - TabBarChildProtocol
    var itemTitle: String = LocalizedStrings.service
    var itemIcon: UIImage? = UIImage(named: "ServiceIcon")

    private let dataSource: ServiceListDataSourceProtocol
    private let viewModel: ServiceListViewModel

    private lazy var tableView: UITableView = {
        let outputTableView = UITableView()

        outputTableView.translatesAutoresizingMaskIntoConstraints = false
        outputTableView.tableFooterView = UIView()
        outputTableView.register(ServiceItemCell.self, forCellReuseIdentifier: ServiceItemCellModel.cellIdentifier)
        return outputTableView
    }()

    private let disposeBag = DisposeBag()

    init(dataSource: ServiceListDataSourceProtocol, viewModel: ServiceListViewModel) {
        self.dataSource = dataSource
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("ServiceListViewController init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    // Для демонстрации загрузки из сети
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.updateData()
    }
}

// MARK: - Private

extension ServiceListViewController {

    private func setup() {
        title = itemTitle
        navigationController?.navigationBar.isTranslucent = false
        dataSource.setup(tableView: tableView,
                         cellModels: viewModel.cellModels)

        bindUI()
        setupLayout()
    }

    private func bindUI() {
        // Если происходит загрузка данных и таблица пустая, то показываем анимацию загрузки
        Observable<Void>
            .combineLatest(viewModel.isLoading.distinctUntilChanged().asObservable(),
                      viewModel.cellModels.asObservable()) { [weak self] isLoading, cellModels in
                        (isLoading && cellModels.count == 0) ? self?.startLoadingAnimation() : self?.stopLoadingAnimation() }
            .subscribe()
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

    private func startLoadingAnimation() {
        let activityIndicator = UIActivityIndicatorView(style: .gray)

        activityIndicator.startAnimating()
        tableView.backgroundView = activityIndicator
    }

    private func stopLoadingAnimation() {
        tableView.backgroundView = nil
    }
}
