//
//  ServiceRepositoryProtocol.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ServiceRepositoryProtocol {

    func obtainServiceListItems() -> Single<[ServiceListItemModel]>
}
