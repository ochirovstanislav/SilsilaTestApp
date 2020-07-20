//
//  ServiceRepository.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import RxSwift
import RxCocoa

// Репозиторий для работы с ListItem сущностями. Прослойка между бизнес логикой и данными.

final class ServiceRepository: ServiceRepositoryProtocol {

    private let serviceListService: ServiceListServiceProtocol
    private let xmlParserManager: XMLParserManager
    private let disposeBag = DisposeBag()

    init(serviceListService: ServiceListServiceProtocol, xmlParserManager: XMLParserManager) {
        self.serviceListService = serviceListService
        self.xmlParserManager = xmlParserManager
    }

    // 
    func obtainServiceListItems() -> Single<[ServiceListItemModel]> {
        return serviceListService.getServiceList().flatMap { [unowned self] data in
            return self.xmlParserManager.parse(from: data)
        }
    }
}
