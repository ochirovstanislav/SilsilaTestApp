//
//  ServiceListViewModel.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import RxSwift
import RxCocoa

final class ServiceListViewModel {

    private struct Constants {
        static let delayInterval: RxTimeInterval = .seconds(3)
    }

    let cellModels = BehaviorRelay<[ServiceItemCellModel]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)

    private let serviceRepository: ServiceRepositoryProtocol
    private let listModels = BehaviorRelay<[ServiceListItemModel]>(value: [])
    private let disposeBag = DisposeBag()

    init(serviceRepository: ServiceRepositoryProtocol) {
        self.serviceRepository = serviceRepository

        bind()
    }

    func updateData() {
        isLoading.accept(true)

        // Cтоит делей для того чтобы успеть увидеть процесс загрузки
        serviceRepository.obtainServiceListItems().delay(Constants.delayInterval, scheduler: MainScheduler.instance).subscribe(onSuccess: { [weak self] (models) in
            self?.listModels.accept(models)
            self?.isLoading.accept(false)
        }).disposed(by: disposeBag)
    }

    private func bind() {
        listModels
            .map { $0.map { ServiceItemCellModel(title: $0.title,
                                                 artist: $0.artist,
                                                 country: $0.country,
                                                 company: $0.company,
                                                 price: $0.price,
                                                 year: $0.year) } }
            .bind(to: cellModels).disposed(by: disposeBag)
    }
}
